{
  pkgs,
  lib,
  config,
  ...
}: let
  # This should only go for personal machines outside of work
  isPersonal = builtins.elem config.systemSettings.profile ["gaming" "personal"];
  username = config.userSettings.username;
  hostname = config.systemSettings.hostname;
in {
  systemd = {
    user = {
    tmpfiles = {
      users.${username} = {
          rules = []
            ++ lib.optionals isPersonal [
          # nixos-user-tmpfiles.d-${username}
          # Ensure the directory exists for use by mpd
          "d /home/${username}/.config/mpd 0755 ${username} ${username} -"
          "d /home/${username}/.config/mpd/playlists 0755 ${username} ${username} -"
        ];

      };
    };
    };
    tmpfiles = {
      rules =
        [
        ]
        ++ lib.optionals (hostname == "h31mda11")
        [
          # Mask the stypid tpm device, getting firmware issues
          "L /etc/systemd/system/tpm2.target - - - - /dev/null"
        ];
    };

    services = {
      mpd.environment = lib.optionalAttrs isPersonal {
        # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
        XDG_RUNTIME_DIR = "/run/user/1000"; # User-id must match above user. MPD will look inside this directory for the PipeWire socket.
      };

      tpm2.enable = false;
    };
  };
}
