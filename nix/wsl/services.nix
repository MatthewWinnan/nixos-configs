# Services specific to my headless servers
{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ../services/ssh.nix
    ../services/blueman.nix
    ../services/printing.nix
    ../services/wsl_overrides.nix
  ];
}
