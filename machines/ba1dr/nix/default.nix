# For nixOS specific imports
{inputs, ...}: {
  imports = [
    # Gaming specific imports
    ../../../gaming/ba1dr
    # Hardware declarations
    ./hardware-configuration.nix
    # Import nixOS settings
    ../../../nix
    # Settings
    ../settings
    # Rather import themes here
    ../../../themes
    # Boot settings
    ./boot.nix
    # Tailscale for mesh networking
    ./tailscale.nix
    # Jellyfin media server
    ../../../nix/services/jellyfin.nix
    # Media automation stack (arr suite)
    ../../../nix/services/media-stack.nix
    # System monitoring (CPU/RAM → MQTT → Home Assistant)
    ../../../nix/services/system-monitor.nix
  ];
}
