# Also worthwhile to check https://nixos.wiki/wiki/MPD#PipeWire
{pkgs, config, ...}: {
  services.mpd = {
    enable = true;

    # Rather have it run under my name, makes things easier to do a per user
    # https://wiki.archlinux.org/title/Music_Player_Daemon#Per-user_configuration
    user = "${config.userSettings.username}";

    dataDir = "/home/${config.userSettings.username}/.config/mpd";
    musicDirectory = "/home/${config.userSettings.username}/Media/Music";
    extraConfig = ''
      auto_update "yes"

      audio_output {
        type            "pipewire"
        name            "PipeWire Sound Server"
      }
    '';
  };
}
