# Services specific to my headless servers
{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ../../../../nix/services/ssh.nix
    ../../../../nix/services/blueman.nix
    ../../../../nix/services/printing.nix
    ../../../../nix/services/wsl_overrides.nix
  ];
}
