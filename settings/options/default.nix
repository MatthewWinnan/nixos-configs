{ lib, ... }:

{
  imports = [
    ./deviceSettings.nix
    ./SystemSettings.nix
    ./userSettings.nix
  ];
}