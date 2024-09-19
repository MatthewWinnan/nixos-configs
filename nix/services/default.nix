{ pkgs, lib, ... }:
{
  imports = [
    ./ssh.nix
    ./gnome.nix
    ./dbus.nix
    ./udisks2.nix
  ];

  # Enable blueman
  services.blueman.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
}
