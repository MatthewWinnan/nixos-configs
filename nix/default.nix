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
  security.pki.certificateFiles = lib.mkIf (config.systemSettings.profile == "work") [
    ../certs/nse-services.crt
    ../certs/eto-resign-ca.pem
  ];

  # crates.io CDN 403s requests without a recognized User-Agent
  systemd.services.nix-daemon.environment.NIX_CURL_FLAGS = lib.mkIf (config.systemSettings.profile == "work") "--user-agent nix";

  # Attic watch-store: auto-push new store paths to nse_ep cache
  systemd.services.attic-watch-store = lib.mkIf (config.systemSettings.profile == "work") {
    description = "Attic watch-store — push new Nix store paths to nse_ep";
    after = ["network-online.target"];
    wants = ["network-online.target"];
    wantedBy = ["multi-user.target"];

    environment = {
      SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
      XDG_CONFIG_HOME = "/home/${config.userSettings.username}/.config";
    };

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.attic-client}/bin/attic watch-store --ignore-upstream-cache-filter local:nse_ep";
      Restart = "on-failure";
      RestartSec = 10;
      RestartMaxDelaySec = "5min";
      RestartSteps = 5;
      StartLimitIntervalSec = 600;
      StartLimitBurst = 5;
      User = config.userSettings.username;
      Group = "users";
    };
  };

  # We need these settings for typical work....
  nix.settings = lib.mkMerge [
    (
      lib.mkIf (config.systemSettings.profile == "work")
      {
        # Enable FLakes
        experimental-features = ["nix-command" "flakes"]; # Enabling flakes
        # For an explanation of how this works check -> https://mynixos.com/nixpkgs/option/nix.settings.sandbox
        sandbox = "relaxed";
        # Use nse_ep cache (priority 30) with cache.nixos.org as fallback
        substituters = [
          "https://nse-services.za.netronome.com:5443/nse_ep?priority=30"
          "https://cache.nixos.org?priority=50"
        ];
        trusted-public-keys = [
          "nse_ep:WFCT6O/qy/ZOTidajT3vk56do0GrCeYRl5tCWBvSC7M="
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        ];
        trusted-users = [config.userSettings.username "root"];
        connect-timeout = 5;
        fallback = true;
      }
    )
    (
      lib.mkIf (config.systemSettings.profile == "gaming")
      {
        # Enable FLakes
        experimental-features = ["nix-command" "flakes"]; # Enabling flakes
        # For an explanation of how this works check -> https://mynixos.com/nixpkgs/option/nix.settings.sandbox
        sandbox = "relaxed";
      }
    )
    (
      lib.mkIf (config.systemSettings.profile == "personal")
      {
        # Enable FLakes
        experimental-features = ["nix-command" "flakes"]; # Enabling flakes
        # For an explanation of how this works check -> https://mynixos.com/nixpkgs/option/nix.settings.sandbox
        sandbox = "relaxed";
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
