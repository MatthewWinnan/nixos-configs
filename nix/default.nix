# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, flakePath, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./modules
      ./services
      ./networking
      ../themes/default.nix
      ../settings/security/default.nix
    ];

  # Set your time zone.
  time.timeZone = config.systemSettings.timezone;

  # Select internationalisation properties.
  i18n.defaultLocale = config.systemSettings.locale;

  # We need these settings for typical work....
  nix.settings = {

    # Enable FLakes
    experimental-features = [ "nix-command" "flakes" ]; # Enabling flakes

    # For an explanation of how this works check -> https://mynixos.com/nixpkgs/option/nix.settings.sandbox
    sandbox = "relaxed";

  };

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
