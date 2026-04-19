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
          cards = [ { type = "original-states"; } ];
        }
        {
          title = "Servers";
          path = "servers";
          icon = "mdi:server";
          cards = [
            {
              type = "entities";
              title = "Machine Status";
              entities = [
                { entity = "binary_sensor.th0r_status"; name = "th0r"; }
              ];
            }
            {
              type = "history-graph";
              title = "th0r CPU & RAM";
              hours_to_show = 24;
              entities = [
                { entity = "sensor.th0r_cpu_usage"; name = "CPU"; }
                { entity = "sensor.th0r_ram_usage"; name = "RAM"; }
              ];
            }
            {
              type = "gauge";
              entity = "sensor.th0r_cpu_usage";
              name = "th0r CPU";
              min = 0;
              max = 100;
              severity = {
                green = 0;
                yellow = 60;
                red = 85;
              };
            }
            {
              type = "gauge";
              entity = "sensor.th0r_ram_usage";
              name = "th0r RAM";
              min = 0;
              max = 100;
              severity = {
                green = 0;
                yellow = 70;
                red = 90;
              };
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
