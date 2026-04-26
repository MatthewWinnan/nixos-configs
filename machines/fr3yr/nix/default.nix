# For nixOS specific imports
{ inputs, ... }:
{
  imports = [
    # Hardware declarations
    ./hardware-configuration.nix
    # Import nixOS settings
    ../../../nix/headless
    # Settings
    ../settings
    # Boot settings
    ./boot.nix
    # Secrets management
    ./sops.nix
    # WiFi networking
    ./networking.nix
    # Home Assistant service
    ../../../nix/services/home-assistant.nix
    # Tailscale for remote access
    ../../../nix/services/tailscale.nix
    # System monitoring (CPU/RAM → MQTT → Home Assistant)
    ../../../nix/services/system-monitor.nix
    # GPS daemon + MQTT bridge (K-172 DFRobot GPS module)
    ../../../nix/services/gpsd.nix
    # NTP correcting
    ../../../nix/services/timesyncd.nix
  ];
}
