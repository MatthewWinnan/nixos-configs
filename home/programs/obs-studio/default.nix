# Snagged this directly from https://wiki.nixos.org/wiki/OBS_Studio
{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.obs-studio =
    lib.mkIf (config.systemSettings.profile == "personal" || config.systemSettings.profile == "gaming")
      {
        enable = true;

        # optional Nvidia hardware acceleration
        package = (
          pkgs.obs-studio.override {
            cudaSupport = true;
          }
        );

        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-backgroundremoval
          obs-pipewire-audio-capture
          # obs-vaapi #optional AMD hardware acceleration
          obs-gstreamer
          obs-vkcapture
        ];
      };
}
