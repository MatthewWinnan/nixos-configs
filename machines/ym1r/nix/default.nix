# For nixOS specific imports
{inputs, ...}: {
  imports = [
    # Import nixOS settings
    ./wsl
    # Settings
    ../settings
    # Rather import themes here
    ../../../themes
    # Boot settings
    ./boot.nix
  ];
}
