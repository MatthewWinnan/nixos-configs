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
    ./music-stack.nix
    ./systemd.nix
    ./tailscale.nix
  ];

  # services.xserver.libinput.enable = true;
}
