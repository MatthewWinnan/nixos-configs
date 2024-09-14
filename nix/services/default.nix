{ pkgs, lib, ... }:
{
  imports = [
    ./ssh.nix
  ];

  # Enable blueman
  services.blueman.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
}
