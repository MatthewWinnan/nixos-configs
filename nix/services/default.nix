{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./ssh.nix
    ./fail2ban.nix
    ./gnome.nix
    ./dbus.nix
    ./udisks2.nix
    ./blueman.nix
    ./printing.nix
    ./greetd.nix
    ./pulseaudio.nix
    ./mpd.nix
    ./systemd.nix
  ];

  # services.xserver.libinput.enable = true;
}
