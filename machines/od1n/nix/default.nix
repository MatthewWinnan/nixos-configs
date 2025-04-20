# For nixOS specific imports
{inputs, ...}: {
  imports = [
    # Hardware declarations
    ./hardware-configuration.nix
    # Import nixOS settings
    ../../../nix
    # Settings
    ../settings
    # I also for this one want to import virtualization
    ../../../nix/virtualization
    # Rather import themes here
    ../../../themes
  ];
}
