# Disable hypridle for work machine
{ lib, ... }:
{
  services.hypridle.enable = lib.mkForce false;
}
