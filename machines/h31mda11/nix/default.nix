# For nixOS specific imports
{inputs, ...}: {
  imports = [
    # Gaming specific imports
    ../../../gaming/ba1dr
    # Hardware declarations
    ./hardware-configuration.nix
    # Import nixOS settings
    ../../../nix
    # Settings
    ../settings
    # Rather import themes here
    ../../../themes
  ];
}
