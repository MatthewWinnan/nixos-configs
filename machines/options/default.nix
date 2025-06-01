{lib, ...}: {
  imports = [
    ./deviceSettings.nix
    ./systemSettings.nix
    ./userSettings.nix
    ./imageSettings.nix
  ];
}
