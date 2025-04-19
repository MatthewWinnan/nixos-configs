# Main modules import
{
  config,
  lib,
  ...
}: {
  imports = [
    ./modules
    ./services
    ./networking
    ../themes
    ./security
  ];

  # Set your time zone.
  time.timeZone = config.systemSettings.timezone;

  # Select internationalisation properties.
  i18n.defaultLocale = config.systemSettings.locale;

  # We need these settings for typical work....
  nix.settings = lib.mkMerge [
    (
      lib.mkIf (config.systemSettings.profile == "work")
      {
        # Enable FLakes
        experimental-features = ["nix-command" "flakes"]; # Enabling flakes
        # For an explanation of how this works check -> https://mynixos.com/nixpkgs/option/nix.settings.sandbox
        sandbox = "relaxed";
        # So we can use our local cache
        #always-allow-substitutes = true;
        substituters = ["http://cachix:8080/fossil?priority=30"];
        trusted-public-keys = ["fossil:p3AAkC0+gc/JTzfyajd3W+ewQAQhpuq2bwv5Wa3wcIg="];
        trusted-users = [config.userSettings.username "root"];
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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  # For bluetooth support
  # TODO I should ideally move this to hardware or something
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on bootboot
}
