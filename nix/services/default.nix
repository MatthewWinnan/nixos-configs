{ pkgs, lib, config, ... }:
{
  imports = [
    ./ssh.nix
    ./gnome.nix
    ./dbus.nix
    ./udisks2.nix
    ./blueman.nix
  ];

  # services.xserver.libinput.enable = true;
}
