{pkgs, lib, config, ...}: {

  imports = [
    ./packages.nix
    ./environment
    ./user
    ./boot
    ./applications
    ];
}
