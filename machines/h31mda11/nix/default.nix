# For nixOS specific imports
{inputs, ...}: {
  imports = [
    # Gaming specific imports
    ../../../gaming/h31mda11
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
  ];
}
