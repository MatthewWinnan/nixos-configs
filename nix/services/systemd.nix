{
  pkgs,
  lib,
  config,
  ...
}: let
  # This should only go for personal machines outside of work
  isPersonal = builtins.elem config.systemSettings.profile ["gaming" "personal"];
in {
  systemd.services.mpd.environment = lib.optionalAttrs isPersonal {
    # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
    XDG_RUNTIME_DIR = "/run/user/1000"; # User-id must match above user. MPD will look inside this directory for the PipeWire socket.
  };
}
