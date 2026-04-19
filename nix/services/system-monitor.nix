# System monitoring via MQTT for Home Assistant
# Collects CPU and RAM usage and publishes to the Mosquitto broker on fr3yr.
# Home Assistant auto-discovers the sensors via MQTT discovery.
#
# Machine online/offline state is tracked via MQTT Last Will and Testament (LWT):
#   - Ungraceful disconnect (crash/network loss): broker publishes "offline" automatically
#   - Graceful shutdown: ExecStop publishes "offline"
#   - Boot: discovery service publishes "online"
#
# LWT is implemented via a persistent mosquitto_sub connection (system-monitor-lwt),
# since telegraf's MQTT output plugin does not support will_* fields in this version.
#
# Import this module on any machine you want to monitor.
{
  config,
  pkgs,
  ...
}:
let
  hostname = config.networking.hostName;
  mqttHost = "fr3yr";
  mqttPort = 1883;
  statusTopic = "telegraf/${hostname}/status";

  # Shared availability config for all sensors
  availability = {
    availability_topic = statusTopic;
    payload_available = "online";
    payload_not_available = "offline";
    expire_after = 120; # mark unavailable after 2 missed readings (30s interval)
  };

  device = {
    name = hostname;
    identifiers = [ hostname ];
  };

  # HA MQTT auto-discovery payloads
  cpuDiscovery = builtins.toJSON (
    availability
    // {
      name = "${hostname} CPU Usage";
      object_id = "${hostname}_cpu_usage";
      state_topic = "telegraf/${hostname}/cpu";
      value_template = "{{ (100 - value_json.fields.usage_idle) | round(1) }}";
      unit_of_measurement = "%";
      icon = "mdi:cpu-64-bit";
      state_class = "measurement";
      unique_id = "${hostname}_cpu_usage";
      inherit device;
    }
  );

  diskDiscovery = builtins.toJSON (
    availability
    // {
      name = "${hostname} Disk Usage";
      object_id = "${hostname}_disk_usage";
      state_topic = "telegraf/${hostname}/disk";
      value_template = "{{ value_json.fields.used_percent | round(1) }}";
      unit_of_measurement = "%";
      icon = "mdi:harddisk";
      state_class = "measurement";
      unique_id = "${hostname}_disk_usage";
      inherit device;
    }
  );

  ramDiscovery = builtins.toJSON (
    availability
    // {
      name = "${hostname} RAM Usage";
      object_id = "${hostname}_ram_usage";
      state_topic = "telegraf/${hostname}/mem";
      value_template = "{{ value_json.fields.used_percent | round(1) }}";
      unit_of_measurement = "%";
      icon = "mdi:memory";
      state_class = "measurement";
      unique_id = "${hostname}_ram_usage";
      inherit device;
    }
  );

  # Binary sensor for machine online/offline — no expire_after, purely LWT-driven
  statusDiscovery = builtins.toJSON {
    name = "${hostname} Status";
    object_id = "${hostname}_status";
    state_topic = statusTopic;
    payload_on = "online";
    payload_off = "offline";
    icon = "mdi:server";
    unique_id = "${hostname}_status";
    device_class = "connectivity";
    inherit device;
  };

  pubCmd = "${pkgs.mosquitto}/bin/mosquitto_pub -h ${mqttHost} -p ${toString mqttPort}";
  subCmd = "${pkgs.mosquitto}/bin/mosquitto_sub -h ${mqttHost} -p ${toString mqttPort}";
in
{
  # Telegraf collects metrics and publishes to MQTT
  services.telegraf = {
    enable = true;
    extraConfig = {
      agent = {
        interval = "30s";
        flush_interval = "30s";
      };

      outputs = {
        mqtt = [
          {
            servers = [ "tcp://${mqttHost}:${toString mqttPort}" ];
            topic = ''telegraf/{{.Tag "host"}}/{{.Name}}'';
            data_format = "json";
            json_timestamp_units = "1s";
            retain = true;
          }
        ];
      };

      inputs = {
        cpu = [
          {
            percpu = false;
            totalcpu = true;
            collect_cpu_time = false;
            report_active = false;
          }
        ];
        mem = [ { } ];
        disk = [
          {
            mount_points = [ "/" ];
            ignore_fs = [
              "tmpfs"
              "devtmpfs"
              "devfs"
              "iso9660"
              "overlay"
              "aufs"
              "squashfs"
            ];
          }
        ];
      };
    };
  };

  # Long-running service that holds a persistent MQTT connection with LWT configured.
  # If this machine disconnects ungracefully (crash/power loss), the broker automatically
  # publishes the will payload ("offline") to the status topic.
  systemd.services.system-monitor-lwt = {
    description = "MQTT LWT keepalive for Home Assistant presence";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      Restart = "on-failure";
      RestartSec = "10s";
      # Publish "online" once the connection is established
      ExecStartPost = "${pubCmd} -t '${statusTopic}' -m 'online' --retain";
      # Publish "offline" on graceful shutdown (LWT only fires on ungraceful disconnect)
      ExecStop = "${pubCmd} -t '${statusTopic}' -m 'offline' --retain";
    };
    script = ''
      ${subCmd} \
        --will-topic '${statusTopic}' \
        --will-payload 'offline' \
        --will-retain \
        --will-qos 1 \
        -t '_lwt/${hostname}'
    '';
  };

  # Publish MQTT auto-discovery configs on boot
  systemd.services.system-monitor-discovery = {
    description = "Publish MQTT discovery config for Home Assistant";
    after = [ "network-online.target" "system-monitor-lwt.service" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      Restart = "on-failure";
      RestartSec = "10s";
    };
    script = ''
      ${pubCmd} -t 'homeassistant/sensor/${hostname}_cpu_usage/config' -m '${cpuDiscovery}' --retain
      ${pubCmd} -t 'homeassistant/sensor/${hostname}_ram_usage/config' -m '${ramDiscovery}' --retain
      ${pubCmd} -t 'homeassistant/sensor/${hostname}_disk_usage/config' -m '${diskDiscovery}' --retain
      ${pubCmd} -t 'homeassistant/binary_sensor/${hostname}_status/config' -m '${statusDiscovery}' --retain
    '';
  };
}
