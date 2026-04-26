# GPS daemon + MQTT bridge for K-172 DFRobot GPS module
# Enables gpsd to read NMEA data from /dev/ttyACM0 and exposes it on the
# standard gpsd socket (port 2947). A bridge service polls gpsd via gpspipe
# and publishes TPV reports to MQTT for Home Assistant auto-discovery.
{
  pkgs,
  ...
}:
let
  mqttHost = "localhost";
  mqttPort = 1883;
  gpsTopic = "gps/fr3yr";
  statusTopic = "gps/fr3yr/status";
  pubCmd = "${pkgs.mosquitto}/bin/mosquitto_pub -h ${mqttHost} -p ${toString mqttPort}";
  subCmd = "${pkgs.mosquitto}/bin/mosquitto_sub -h ${mqttHost} -p ${toString mqttPort}";

  gpsDevice = {
    name = "K-172 GPS";
    identifiers = [ "fr3yr_gps" ];
    model = "DFRobot K-172";
    manufacturer = "DFRobot";
  };

  latDiscovery = builtins.toJSON {
    name = "GPS Latitude";
    object_id = "gps_latitude";
    state_topic = "${gpsTopic}/tpv";
    value_template = "{{ value_json.lat | round(6) }}";
    unit_of_measurement = "°";
    icon = "mdi:latitude";
    state_class = "measurement";
    unique_id = "fr3yr_gps_latitude";
    device = gpsDevice;
  };

  lonDiscovery = builtins.toJSON {
    name = "GPS Longitude";
    object_id = "gps_longitude";
    state_topic = "${gpsTopic}/tpv";
    value_template = "{{ value_json.lon | round(6) }}";
    unit_of_measurement = "°";
    icon = "mdi:longitude";
    state_class = "measurement";
    unique_id = "fr3yr_gps_longitude";
    device = gpsDevice;
  };

  altDiscovery = builtins.toJSON {
    name = "GPS Altitude";
    object_id = "gps_altitude";
    state_topic = "${gpsTopic}/tpv";
    value_template = "{{ value_json.alt | round(1) }}";
    unit_of_measurement = "m";
    icon = "mdi:altimeter";
    state_class = "measurement";
    unique_id = "fr3yr_gps_altitude";
    device = gpsDevice;
  };

  speedDiscovery = builtins.toJSON {
    name = "GPS Speed";
    object_id = "gps_speed";
    state_topic = "${gpsTopic}/tpv";
    value_template = "{{ value_json.speed | round(2) }}";
    unit_of_measurement = "m/s";
    icon = "mdi:speedometer";
    state_class = "measurement";
    unique_id = "fr3yr_gps_speed";
    device = gpsDevice;
  };

  fixDiscovery = builtins.toJSON {
    name = "GPS Fix";
    object_id = "gps_fix";
    state_topic = "${gpsTopic}/tpv";
    value_template = ''{{ "ON" if value_json.mode >= 2 else "OFF" }}'';

    icon = "mdi:crosshairs-gps";
    device_class = "connectivity";
    unique_id = "fr3yr_gps_fix";
    device = gpsDevice;
  };

  modeDiscovery = builtins.toJSON {
    name = "GPS Fix Mode";
    object_id = "gps_fix_mode";
    state_topic = "${gpsTopic}/tpv";
    value_template = ''{{ {0: "No Fix", 1: "No Fix", 2: "2D Fix", 3: "3D Fix"}.get(value_json.mode | int, "Unknown") }}'';

    icon = "mdi:satellite-variant";
    unique_id = "fr3yr_gps_fix_mode";
    device = gpsDevice;
  };

  nSatDiscovery = builtins.toJSON {
    name = "GPS Satellites in View";
    object_id = "gps_nsat";
    state_topic = "${gpsTopic}/tpv";
    value_template = "{{ value_json.nSat }}";
    unit_of_measurement = "sat";
    icon = "mdi:satellite-variant";
    state_class = "measurement";
    unique_id = "fr3yr_gps_nsat";
    device = gpsDevice;
  };

  uSatDiscovery = builtins.toJSON {
    name = "GPS Satellites Used";
    object_id = "gps_usat";
    state_topic = "${gpsTopic}/tpv";
    value_template = "{{ value_json.uSat }}";
    unit_of_measurement = "sat";
    icon = "mdi:satellite";
    state_class = "measurement";
    unique_id = "fr3yr_gps_usat";
    device = gpsDevice;
  };

  trackerDiscovery = builtins.toJSON {
    name = "fr3yr GPS";
    object_id = "fr3yr_gps";
    state_topic = "${gpsTopic}/tpv";
    value_template = ''{{ "home" if value_json.mode >= 2 else "not_home" }}'';
    json_attributes_topic = "${gpsTopic}/location";
    source_type = "gps";
    unique_id = "fr3yr_gps_tracker";
    device = gpsDevice;
  };

  # Bridge online/offline status — uses MQTT LWT so HA knows when the bridge
  # process has died. The data sensors intentionally have no availability_topic
  # so they retain their last known value when the bridge is down.
  bridgeStatusDiscovery = builtins.toJSON {
    name = "GPS Bridge";
    object_id = "gps_bridge";
    state_topic = statusTopic;
    payload_on = "online";
    payload_off = "offline";
    icon = "mdi:satellite-uplink";
    device_class = "connectivity";
    unique_id = "fr3yr_gps_bridge";
    device = gpsDevice;
  };
in
{
  # Stable udev symlink for the K-172 GPS module.
  # Matches on USB vendor/product ID so the path is independent of enumeration
  # order — /dev/ttyGPS always points to this specific device.
  #
  # Verify your IDs with:  udevadm info -a -n /dev/ttyACM0 | grep -E 'idVendor|idProduct'
  # U-blox 7 = 1546:01a7 (most VK-172 / K-172 units)
  # U-blox 8 = 1546:01a8
  services.udev.extraRules = ''
    SUBSYSTEM=="tty", ATTRS{idVendor}=="1546", ATTRS{idProduct}=="01a7", \
      SYMLINK+="ttyGPS", GROUP="dialout", MODE="0660"
  '';

  # gpsd reads from the stable symlink, not the raw ttyACM* node
  services.gpsd = {
    enable = true;
    devices = [ "/dev/ttyGPS" ];
    listenany = false;
    # -n: start reading immediately without waiting for a client connection
    # (important for getting a satellite fix on boot)
    extraArgs = [ "-n" ];
  };

  # gpsd needs access to the CDC ACM device (dialout group on Linux)
  users.groups.dialout.members = [ "gpsd" ];

  # GPS debugging tools available in the shell:
  #   cgps        — curses live GPS display (position, fix quality, satellites)
  #   gpsmon      — real-time packet monitor with per-sentence breakdown
  #   gpspipe     — stream raw NMEA or JSON from gpsd  (e.g. gpspipe -r | head)
  #   ubxtool     — query / configure the U-blox chip directly
  #   gpsfake     — replay a recorded NMEA file for offline testing
  #   gpscat      — cat a serial device and feed it to gpsd
  #   picocom     — raw serial terminal, bypasses gpsd entirely
  #                 (e.g. picocom -b 9600 /dev/ttyGPS)
  environment.systemPackages = with pkgs; [
    gpsd # brings cgps, gpsmon, gpspipe, ubxtool, gpsfake, gpscat
    picocom # raw serial terminal for direct NMEA inspection
  ];

  # Open port 2947 locally so gpspipe and other clients can talk to the daemon
  networking.firewall.allowedTCPPorts = [ 2947 ];

  # Long-running connection that holds the LWT for the bridge.
  # If this process dies (crash/power loss) the broker automatically publishes
  # "offline" to the status topic. Graceful shutdown publishes it via ExecStop.
  systemd.services.gps-mqtt-lwt = {
    description = "MQTT LWT keepalive and USB device monitor for GPS bridge status";
    after = [ "mosquitto.service" "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      Restart = "on-failure";
      RestartSec = "10s";
    };
    script = ''
      cleanup() {
        ${pubCmd} -t '${statusTopic}' -m 'offline' --retain
        kill "$LWT_PID" 2>/dev/null
        exit 0
      }
      trap cleanup SIGTERM SIGINT

      # Persistent connection — broker fires the will if this process dies ungracefully
      ${subCmd} \
        --will-topic '${statusTopic}' \
        --will-payload 'offline' \
        --will-retain \
        --will-qos 1 \
        -t '_lwt/gps_bridge' &
      LWT_PID=$!

      # Poll device presence every 5 seconds and publish status on change
      last_state=""
      while true; do
        if [ -e /dev/ttyGPS ]; then
          state="online"
        else
          state="offline"
        fi

        if [ "$state" != "$last_state" ]; then
          ${pubCmd} -t '${statusTopic}' -m "$state" --retain
          last_state="$state"
        fi

        sleep 5
      done
    '';
  };

  # Bridge: reads TPV reports from gpsd and publishes JSON to MQTT.
  # Data sensors have no availability_topic — HA keeps the last retained value
  # when this service is down. The gps-mqtt-lwt service tracks up/down state.
  systemd.services.gps-mqtt-bridge = {
    description = "GPS to MQTT bridge (K-172 gpsd -> Mosquitto)";
    after = [
      "gpsd.service"
      "mosquitto.service"
      "gps-mqtt-lwt.service"
    ];
    wants = [
      "gpsd.service"
      "mosquitto.service"
    ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      Restart = "always";
      RestartSec = "15s";
    };
    path = with pkgs; [
      gpsd
      jq
      mosquitto
    ];
    script = ''
      # Wait for gpsd socket to be ready
      sleep 2

      nsat=0
      usat=0
      last_pub=0

      # Pre-filter to TPV/SKY only — avoids jq entirely for all other message classes
      gpspipe -w | grep -E '"class":"(TPV|SKY)"' | while IFS= read -r line; do

        # Use bash pattern matching for class detection — no subprocess
        if [[ "$line" == *'"class":"SKY"'* ]]; then
          now=$(date +%s)
          # Only parse SKY when we're within one cycle of publishing
          [ $((now - last_pub)) -lt 9 ] && continue
          read -r nsat usat < <(echo "$line" | jq -r '"\(.nSat // 0) \(.uSat // 0)"')
          continue
        fi

        now=$(date +%s)
        [ $((now - last_pub)) -lt 10 ] && continue
        last_pub=$now

        payload=$(echo "$line" | jq \
          --argjson nSat "$nsat" \
          --argjson uSat "$usat" \
          '{lat: .lat, lon: .lon, alt: .alt, speed: .speed, mode: .mode, nSat: $nSat, uSat: $uSat}')

        mosquitto_pub -h ${mqttHost} -p ${toString mqttPort} \
          -t '${gpsTopic}/tpv' -m "$payload" --retain

        # Separate location topic for the HA device_tracker / map card
        location=$(echo "$line" | jq \
          '{latitude: .lat, longitude: .lon, gps_accuracy: ((.eph // 999) | round)}')
        mosquitto_pub -h ${mqttHost} -p ${toString mqttPort} \
          -t '${gpsTopic}/location' -m "$location" --retain
      done
    '';
  };

  # Publish MQTT auto-discovery configs on boot so HA picks up the sensors
  systemd.services.gps-mqtt-discovery = {
    description = "Publish GPS MQTT discovery config for Home Assistant";
    after = [
      "mosquitto.service"
      "network-online.target"
    ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      Restart = "on-failure";
      RestartSec = "10s";
    };
    script = ''
      ${pubCmd} -t 'homeassistant/sensor/gps_latitude/config'             -m '${latDiscovery}'          --retain
      ${pubCmd} -t 'homeassistant/sensor/gps_longitude/config'            -m '${lonDiscovery}'          --retain
      ${pubCmd} -t 'homeassistant/sensor/gps_altitude/config'             -m '${altDiscovery}'          --retain
      ${pubCmd} -t 'homeassistant/sensor/gps_speed/config'                -m '${speedDiscovery}'        --retain
      ${pubCmd} -t 'homeassistant/sensor/gps_fix_mode/config'             -m '${modeDiscovery}'         --retain
      ${pubCmd} -t 'homeassistant/binary_sensor/gps_fix/config'           -m '${fixDiscovery}'          --retain
      ${pubCmd} -t 'homeassistant/sensor/gps_nsat/config'                 -m '${nSatDiscovery}'         --retain
      ${pubCmd} -t 'homeassistant/sensor/gps_usat/config'                 -m '${uSatDiscovery}'         --retain
      ${pubCmd} -t 'homeassistant/binary_sensor/gps_bridge/config'        -m '${bridgeStatusDiscovery}' --retain
      ${pubCmd} -t 'homeassistant/device_tracker/fr3yr_gps/config'       -m '${trackerDiscovery}'       --retain
    '';
  };
}
