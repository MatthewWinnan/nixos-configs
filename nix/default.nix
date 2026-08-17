# Main modules import
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./applications
    ./services
    ./networking
    ./security
    ./environment
    ./user
  ];

  # Set your time zone.
  time.timeZone = config.systemSettings.timezone;

  # Select internationalisation properties.
  i18n.defaultLocale = config.systemSettings.locale;

  # Trust nse-services self-signed cert for nix cache + ETO resign CA
  # Trust nse-services self-signed cert for nix cache + ETO resign CA
  # Only needed on office network where these services are reachable
  security.pki.certificateFiles = lib.mkIf (config.systemSettings.profile == "work" && config.deviceSettings.location == "work") [
    ../certs/nse-services.crt
    ../certs/eto-resign-ca.pem
    ../certs/gitlab.pem
  ];

  # crates.io CDN 403s requests without a recognized User-Agent (work proxy rewrites)
  systemd.services.nix-daemon.environment.NIX_CURL_FLAGS = lib.mkIf (config.systemSettings.profile == "work" && config.deviceSettings.location == "work") "--user-agent nix";

  # We need these settings for typical work....
  nix.settings = lib.mkMerge [
    (
      lib.mkIf (config.systemSettings.profile == "work")
      {
        # Enable FLakes
        experimental-features = ["nix-command" "flakes"]; # Enabling flakes
        # For an explanation of how this works check -> https://mynixos.com/nixpkgs/option/nix.settings.sandbox
        sandbox = "relaxed";

        # Ensure Nix fixed-output derivation fetches (e.g. fetchgit) trust our
        # proxy's re-signed certs (ETO resign CA). Without this, sources hosted
        # on sites like Codeberg fail SSL verification inside the sandbox.
        ssl-cert-file = "/etc/ssl/certs/ca-certificates.crt";

        trusted-users = [config.userSettings.username "root"];
        connect-timeout = 5;
        fallback = true;
      }
    )
    (
      # nse-services cache only available on office network
      lib.mkIf (config.systemSettings.profile == "work" && config.deviceSettings.location == "work")
      {
        # Use nse_ep cache (priority 30) with cache.nixos.org as fallback
        # NOTE: This URL is an internal FQDN (not resolvable externally).
        # Accepted exposure in public repo — no secrets, just topology hint.
        substituters = [
          "https://nse-services.ci.dec.iotrap.com:5443/nse_ep?priority=30"
          "https://cache.nixos.org?priority=50"
        ];
        trusted-public-keys = [
          "nse_ep:WFCT6O/qy/ZOTidajT3vk56do0GrCeYRl5tCWBvSC7M="
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        ];
      }
    )
    (
      # At home, only use cache.nixos.org
      lib.mkIf (config.systemSettings.profile == "work" && config.deviceSettings.location == "home")
      {
        substituters = [
          "https://cache.nixos.org?priority=50"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        ];
      }
    )
    (
      lib.mkIf (config.systemSettings.profile == "gaming")
      {
        # Enable FLakes
        experimental-features = ["nix-command" "flakes"]; # Enabling flakes
        # For an explanation of how this works check -> https://mynixos.com/nixpkgs/option/nix.settings.sandbox
        sandbox = "relaxed";
        http-connections = 50;
        trusted-users = [config.userSettings.username "root"];
        substituters = [ "https://aseipp-nix-cache.global.ssl.fastly.net?priority=30" 
          "https://cache.nixos.org?priority=50"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        ];
      }
    )
    (
      lib.mkIf (config.systemSettings.profile == "personal")
      {
        # Enable FLakes
        experimental-features = ["nix-command" "flakes"]; # Enabling flakes
        # For an explanation of how this works check -> https://mynixos.com/nixpkgs/option/nix.settings.sandbox
        sandbox = "relaxed";
        trusted-users = [config.userSettings.username "root"];
      }
    )
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  # For bluetooth support
  # TODO I should ideally move this to hardware or something
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on bootboot
}
