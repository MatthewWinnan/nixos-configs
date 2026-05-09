# Home Assistant configuration for fr3yr
{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Home Assistant service
  services.home-assistant = {
    enable = true;

    # Extra components to include
    extraComponents = [
      # Core integrations
      "default_config"
      "onboarding"
      "met" # Weather
      "radio_browser" # Media

      # Network & Discovery
      "network"
      "dhcp"
      "ssdp"
      "zeroconf"
      "homeassistant_alerts"
      "analytics"

      # Mobile & Remote Access
      "mobile_app"
      "webhook"

      # Smart Home Protocols
      "mqtt" # MQTT messaging
      "esphome" # ESP-based devices
      "zha" # Zigbee Home Automation

      # Automation
      "automation"
      "scene"
      "script"
      "input_boolean"
      "input_number"
      "input_select"
      "input_text"
      "input_datetime"
      "input_button"
      "counter"
      "timer"

      # Media
      "media_player"
      "media_source"
      "google_translate" # TTS - requires gtts

      # History & Logging
      "recorder"
      "history"
      "logbook"

      # Utility
      "sun"
      "person"
      "zone"
    ];

    # Extra Python packages for integrations
    extraPackages =
      python3Packages: with python3Packages; [
        # MQTT support
        aiomqtt
        # For Zigbee
        zigpy
        # For ESPHome
        aioesphomeapi
        # Additional utilities
        numpy
        pillow
      ];

    # Lovelace dashboard — fully declarative, managed by Nix
    # Set lovelaceConfigWritable = true if you want to also edit via the HA UI
    lovelaceConfigWritable = false;
    lovelaceConfig = {
      title = "Home";
      views = [
        {
          title = "Overview";
          icon = "mdi:home";
          cards = [
            {
              type = "weather-forecast";
              entity = "weather.forecast_home";
              forecast_type = "daily";
            }
            {
              type = "entities";
              title = "Machine Status";
              entities = [
                { entity = "binary_sensor.th0r_status"; name = "th0r"; }
                { entity = "binary_sensor.fr3yr_status"; name = "fr3yr"; }
                { entity = "binary_sensor.h31mda11_status"; name = "h31mda11"; }
                { entity = "binary_sensor.ba1dr_status"; name = "ba1dr"; }
              ];
            }
          ];
        }
        {
          title = "Servers";
          path = "servers";
          icon = "mdi:server";
          cards = map
            (m: {
              type = "vertical-stack";
              cards = [
                {
                  type = "history-graph";
                  title = "${m.host} CPU / RAM / Disk";
                  hours_to_show = 24;
                  entities = [
                    { entity = "sensor.${m.id}_cpu_usage"; name = "CPU"; }
                    { entity = "sensor.${m.id}_ram_usage"; name = "RAM"; }
                    { entity = "sensor.${m.id}_disk_usage"; name = "Disk"; }
                  ];
                }
                {
                  type = "horizontal-stack";
                  cards = [
                    {
                      type = "gauge";
                      entity = "sensor.${m.id}_cpu_usage";
                      name = "CPU";
                      min = 0;
                      max = 100;
                      severity = { green = 0; yellow = 60; red = 85; };
                    }
                    {
                      type = "gauge";
                      entity = "sensor.${m.id}_ram_usage";
                      name = "RAM";
                      min = 0;
                      max = 100;
                      severity = { green = 0; yellow = 70; red = 90; };
                    }
                    {
                      type = "gauge";
                      entity = "sensor.${m.id}_disk_usage";
                      name = "Disk";
                      min = 0;
                      max = 100;
                      severity = { green = 0; yellow = 70; red = 90; };
                    }
                  ];
                }
              ];
            })
            [
              { host = "th0r";     id = "th0r"; }
              { host = "fr3yr";    id = "fr3yr"; }
              { host = "h31mda11"; id = "h31mda11"; }
              { host = "ba1dr";    id = "ba1dr"; }
            ];
        }
        {
          title = "Weather Station";
          path = "weather-station";
          icon = "mdi:thermometer";
          cards = [
            {
              type = "vertical-stack";
              cards = [
                {
                  type = "entities";
                  title = "BMP180";
                  entities = [
                    { entity = "sensor.bmp180_temperature";    name = "Temperature"; }
                    { entity = "sensor.bmp180_pressure";       name = "Pressure (QFE)"; }
                    { entity = "sensor.bmp180_pressure_msl";   name = "Pressure MSL (QNH)"; }
                    { entity = "sensor.bmp180_altitude";       name = "Altitude (barometric)"; }
                  ];
                }
                {
                  type = "entities";
                  title = "BME280";
                  entities = [
                    { entity = "sensor.bme280_temperature";    name = "Temperature"; }
                    { entity = "sensor.bme280_pressure";       name = "Pressure (QFE)"; }
                    { entity = "sensor.bme280_pressure_msl";   name = "Pressure MSL (QNH)"; }
                    { entity = "sensor.bme280_altitude";       name = "Altitude (barometric)"; }
                    { entity = "sensor.bme280_humidity";       name = "Humidity"; }
                  ];
                }
                {
                  type = "entities";
                  title = "Pico UPS-A Battery";
                  entities = [
                    { entity = "sensor.pico_w_battery";  name = "Battery"; }
                    { entity = "sensor.pico_w_voltage";  name = "Voltage"; }
                    { entity = "sensor.pico_w_current";  name = "Current"; }
                  ];
                }
                {
                  type = "history-graph";
                  title = "Temperature & Humidity (24 h)";
                  hours_to_show = 24;
                  entities = [
                    { entity = "sensor.bmp180_temperature";    name = "BMP180 Temp"; }
                    { entity = "sensor.bme280_temperature";    name = "BME280 Temp"; }
                    { entity = "sensor.bme280_humidity";       name = "Humidity"; }
                  ];
                }
                {
                  type = "history-graph";
                  title = "Pressure (24 h)";
                  hours_to_show = 24;
                  entities = [
                    { entity = "sensor.bmp180_pressure";       name = "BMP180 QFE"; }
                    { entity = "sensor.bmp180_pressure_msl";   name = "BMP180 QNH"; }
                    { entity = "sensor.bme280_pressure";       name = "BME280 QFE"; }
                    { entity = "sensor.bme280_pressure_msl";   name = "BME280 QNH"; }
                  ];
                }
                {
                  type = "history-graph";
                  title = "Altitude (24 h)";
                  hours_to_show = 24;
                  entities = [
                    { entity = "sensor.bmp180_altitude";       name = "BMP180"; }
                    { entity = "sensor.bme280_altitude";       name = "BME280"; }
                  ];
                }
                {
                  type = "history-graph";
                  title = "Battery (24 h)";
                  hours_to_show = 24;
                  entities = [
                    { entity = "sensor.pico_w_battery";  name = "Battery %"; }
                    { entity = "sensor.pico_w_voltage";  name = "Voltage"; }
                  ];
                }
              ];
            }
          ];
        }
        {
          title = "Air Quality";
          path = "air-quality";
          icon = "mdi:air-filter";
          cards = [
            {
              type = "vertical-stack";
              cards = [
                {
                  type = "entities";
                  title = "PM Concentrations";
                  entities = [
                    { entity = "sensor.air_pm1_0"; name = "PM1.0"; }
                    { entity = "sensor.air_pm2_5"; name = "PM2.5"; }
                    { entity = "sensor.air_pm10";  name = "PM10"; }
                  ];
                }
                {
                  type = "entities";
                  title = "Particle Counts (per 0.1 L)";
                  entities = [
                    { entity = "sensor.air_cnt_03";  name = ">0.3 µm"; }
                    { entity = "sensor.air_cnt_05";  name = ">0.5 µm"; }
                    { entity = "sensor.air_cnt_10";  name = ">1.0 µm"; }
                    { entity = "sensor.air_cnt_25";  name = ">2.5 µm"; }
                    { entity = "sensor.air_cnt_50";  name = ">5.0 µm"; }
                    { entity = "sensor.air_cnt_100"; name = ">10 µm"; }
                  ];
                }
                {
                  type = "history-graph";
                  title = "PM Concentrations (24 h)";
                  hours_to_show = 24;
                  entities = [
                    { entity = "sensor.air_pm1_0"; name = "PM1.0"; }
                    { entity = "sensor.air_pm2_5"; name = "PM2.5"; }
                    { entity = "sensor.air_pm10";  name = "PM10"; }
                  ];
                }
                {
                  type = "history-graph";
                  title = "Fine Particles (24 h)";
                  hours_to_show = 24;
                  entities = [
                    { entity = "sensor.air_cnt_03"; name = ">0.3 µm"; }
                    { entity = "sensor.air_cnt_05"; name = ">0.5 µm"; }
                    { entity = "sensor.air_cnt_10"; name = ">1.0 µm"; }
                  ];
                }
              ];
            }
          ];
        }
        {
          title = "GPS";
          path = "gps";
          icon = "mdi:satellite-variant";
          cards = [
            {
              type = "map";
              entities = [ { entity = "device_tracker.fr3yr_gps"; } ];
              hours_to_show = 1;
              zoom = 14;
            }
            {
              type = "entities";
              title = "K-172 GPS Module";
              entities = [
                { entity = "binary_sensor.gps_bridge";   name = "Bridge Online"; }
                { entity = "binary_sensor.gps_fix";      name = "Fix Acquired"; }
                { entity = "sensor.gps_fix_mode";        name = "Fix Mode"; }
                { entity = "sensor.gps_nsat";            name = "nSat (in View)"; }
                { entity = "sensor.gps_usat";            name = "uSat (Used)"; }
                { entity = "sensor.gps_latitude";        name = "Latitude (last known)"; }
                { entity = "sensor.gps_longitude";       name = "Longitude (last known)"; }
                { entity = "sensor.gps_altitude";        name = "Altitude (last known)"; }
                { entity = "sensor.gps_speed";           name = "Speed (last known)"; }
              ];
            }
          ];
        }
      ];
    };

    # Home Assistant configuration (converted to YAML)
    config = {
      # Basic configuration
      homeassistant = {
        name = "Home";
        latitude = "!secret latitude";
        longitude = "!secret longitude";
        elevation = "!secret elevation";
        unit_system = "metric";
        time_zone = config.systemSettings.timezone or "Africa/Johannesburg";
        currency = "ZAR";
        country = "ZA";
        language = "en";
      };

      # Default integrations
      default_config = { };

      # Frontend configuration
      frontend = {
        themes = "!include_dir_merge_named themes";
      };

      # HTTP configuration for reverse proxy support
      http = {
        server_host = "0.0.0.0";
        server_port = 8123;
        use_x_forwarded_for = true;
        trusted_proxies = [
          "127.0.0.1"
          "::1"
          "100.64.0.0/10" # Tailscale CGNAT range
          "192.168.101.0/24" # Local LAN (th0r proxy)
        ];
      };

      # Recorder for history
      recorder = {
        db_url = "sqlite:////var/lib/hass/home-assistant_v2.db";
        purge_keep_days = 10;
      };

      # Logging
      logger = {
        default = "info";
        logs = {
          "homeassistant.core" = "warning";
          "homeassistant.components.mqtt" = "warning";
        };
      };

      # Automation placeholder
      automation = "!include automations.yaml";
      script = "!include scripts.yaml";
      scene = "!include scenes.yaml";
    };
  };

  # Create required YAML files that Home Assistant expects
  systemd.tmpfiles.rules = [
    "f /var/lib/hass/automations.yaml 0644 hass hass - []"
    "f /var/lib/hass/scripts.yaml 0644 hass hass - {}"
    "f /var/lib/hass/scenes.yaml 0644 hass hass - []"
    "d /var/lib/hass/themes 0755 hass hass -"
  ];

  # Open firewall for Home Assistant
  networking.firewall = {
    allowedTCPPorts = [
      8123 # Home Assistant web UI
      1883 # Mosquitto port
    ];
  };

  # Optional: Mosquitto MQTT broker
  services.mosquitto = {
    enable = true;
    listeners = [
      {
        acl = [ "pattern readwrite #" ];
        omitPasswordAuth = true;
        settings.allow_anonymous = true;
      }
    ];
  };

  # Mosquitto CLI tools for testing
  environment.systemPackages = [ pkgs.mosquitto ];
}
