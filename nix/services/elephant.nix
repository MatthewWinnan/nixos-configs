{ config, pkgs, lib, ... }:
{
  services.elephant.enable = true;

  # Elephant needs user/system profiles in PATH to resolve bare command
  # names (e.g. "chromium") from .desktop Exec= lines, plus bash for
  # executing them and standard tools for its runner provider.
  systemd.user.services.elephant = {
    environment.PATH = lib.mkForce (
      lib.concatStringsSep ":" [
        "${config.users.users.${config.userSettings.username}.home}/.nix-profile/bin"
        "/run/current-system/sw/bin"
        (lib.makeBinPath [
          pkgs.bash
          pkgs.coreutils
          pkgs.findutils
          pkgs.gnugrep
          pkgs.gnused
          pkgs.systemd
        ])
      ]
    );
    wantedBy = lib.mkForce [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
  };
}
