# For nixOS specific imports
{inputs, ...}: {
  imports = [
    # Hardware declarations
    ./hardware-configuration.nix
    # Import nixOS settings
    ../../../nix/headless
    # Settings
    ../settings
    # Rather import themes here
    ../../../themes
  ];
}
