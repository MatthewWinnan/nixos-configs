# WiFi networking configuration for fr3yr using iwd
{
  config,
  lib,
  ...
}:
{
  networking.wireless = {
    # Disable wpa_supplicant since we're using iwd
    enable = false;

    iwd = {
      enable = true;
      settings = {
        General = {
          EnableNetworkConfiguration = false;
          AddressRandomization = "once";
        };
        Network = {
          EnableIPv6 = true;
          NameResolvingService = "systemd";
        };
        Settings = {
          AutoConnect = true;
        };
      };
    };
  };

  # iwd network profile is created by sops-nix
  # The file will be placed at /var/lib/iwd/<SSID>.psk
}
