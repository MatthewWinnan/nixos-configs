# WiFi networking configuration for fr3yr
{
  config,
  lib,
  ...
}: {
  networking.wireless = {
    enable = true;

    # Use sops-nix secrets file for credentials
    # File format: KEY=value pairs, referenced as @KEY@ in config
    secretsFile = config.sops.secrets."wifi-secrets".path;

    networks = {
      "@WIFI_SSID@" = {
        pskRaw = "@WIFI_PSK@";
      };
    };
  };
}
