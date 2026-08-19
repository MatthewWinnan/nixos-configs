{ config, pkgs, lib, ... }:
{
  services.elephant.enable = true;

  # Elephant needs user/system profiles in PATH to resolve bare command
  # names (e.g. "chromium") from .desktop Exec= lines, plus bash for
  # executing them and standard tools for its runner provider.
  #
  # home-manager runs as a NixOS module with useUserPackages, so per-user
  # packages live in /etc/profiles/per-user/<name>/bin — ~/.nix-profile is a
  # dangling symlink here. The home profile is kept as a fallback for any
  # machine using a standalone nix profile instead.
  systemd.user.services.elephant = {
    environment.PATH = lib.mkForce (
      lib.concatStringsSep ":" [
        "/etc/profiles/per-user/${config.userSettings.username}/bin"
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
