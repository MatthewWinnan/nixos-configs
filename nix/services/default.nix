{ pkgs, lib, ... }:

{

  # List services that you want to enable

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  # Display manager
  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Enable blueman
  services.blueman.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

}