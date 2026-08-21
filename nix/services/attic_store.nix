# attic watch-store: continuously push new store paths to a binary cache.
#
# One service, two targets, because the fleet has two caches:
#   work     -> nse-services:nse_ep  (the office cache)
#   personal -> nixos on th0r        (nix/services/atticd.nix)
#
# Kept in a single module deliberately. A second module defining
# systemd.services.attic-watch-store for the other profile would collide by
# name and drift apart, which is the failure mode nix/common exists to avoid.
#
# `attic watch-store` tails the Nix store and uploads anything new. The work
# cache passes --ignore-upstream-cache-filter to mirror everything, since that
# network cannot reach cache.nixos.org. The personal cache leaves the filter
# on, so it only stores paths that are NOT already public - no point
# re-uploading nixpkgs to your own disk.
#
# Credentials come from ~/.config/attic/config.toml, written by `attic login`.
# That is imperative and per-machine: until it has been run the service fails
# and retries.
{
  config,
  lib,
  pkgs,
  ...
}: let
  user = config.userSettings.username;
  isWork = config.systemSettings.profile == "work";

  target =
    if isWork
    then "--ignore-upstream-cache-filter nse-services:nse_ep"
    else "nixos";
in {
  systemd.services.attic-watch-store = {
    description = "Attic watch-store — push new Nix store paths to the binary cache";
    # The personal cache is reached by MagicDNS name, which does not resolve
    # until tailscaled is up.
    after = ["network-online.target"] ++ lib.optional (!isWork) "tailscaled.service";
    wants = ["network-online.target"];
    wantedBy = ["multi-user.target"];

    environment = {
      SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
      XDG_CONFIG_HOME = "/home/${user}/.config";
    };

    unitConfig = {
      # Retry indefinitely rather than giving up. This service legitimately
      # fails on a machine where `attic login` has not been run yet, and should
      # recover by itself once it has.
      #
      # NB these are [Unit] directives - they were previously under
      # serviceConfig, where systemd ignores them.
      StartLimitIntervalSec = 0;
    };

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.attic-client}/bin/attic watch-store ${target}";
      Restart = "on-failure";
      RestartSec = 10;
      RestartMaxDelaySec = "5min";
      RestartSteps = 5;
      User = user;
      Group = "users";
    };
  };
}
