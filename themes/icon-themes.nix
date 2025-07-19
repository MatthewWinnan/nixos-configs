# Just store all of my themes here
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    networkmanagerapplet
  ];
}
