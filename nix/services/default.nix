{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./ssh.nix
    ./gnome.nix
    ./dbus.nix
    ./udisks2.nix
    ./blueman.nix
    ./printing.nix
  ];

  # services.xserver.libinput.enable = true;
}
