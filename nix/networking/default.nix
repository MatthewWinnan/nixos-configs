{ config, ... }:
{
  networking = {
    hostName = config.systemSettings.hostname;
    networkmanager = {
      enable = true;
      wifi.backend = "iwd"; # Use iwd as NetworkManager's backend
    };
    wireless = {
      enable = false; # Disable wpa_supplicant - conflicts with iwd
      iwd = {
        enable = true;
        settings = {
          General = {
            EnableNetworkConfiguration = false; # Let NetworkManager handle IP config
            AddressRandomization = "once"; # Randomize MAC on startup
          };
          Network = {
            EnableIPv6 = true;
            NameResolvingService = "systemd"; # Use systemd-resolved for DNS
          };
          Settings = {
            AutoConnect = true; # Auto-connect to known networks
          };
        };
      };
    };
    firewall = {
      enable = true;
      # Firewall DOCS-> https://nixos.wiki/wiki/Firewall
      allowedTCPPorts = [
        5000
        465
        993
      ];
    };
  };
}
