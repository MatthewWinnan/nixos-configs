# Jellyfin media server with hardware transcoding
#
# Post-install configuration required (via web UI at http://<host>:8096):
#   1. Base URL: Dashboard → Networking → Base URL → set to "/media"
#   2. Hardware acceleration: Dashboard → Playback → Transcoding
#      - Hardware acceleration: NVIDIA NVENC
#      - Enable hardware decoding for: H.264, HEVC, HEVC 10-bit
#   3. Add media libraries
#
# Persistent storage in /persist/jellyfin
{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.jellyfin = {
    enable = true;
    openFirewall = true; # Opens port 8096
  };

  # Grant Jellyfin access to GPU for hardware transcoding
  users.users.jellyfin.extraGroups = [
    "video"
    "render"
  ];

  # Persist Jellyfin data across rebuilds
  systemd.tmpfiles.rules = [
    "d /persist/jellyfin 0755 jellyfin jellyfin -"
    "d /persist/jellyfin/config 0755 jellyfin jellyfin -"
    "d /persist/jellyfin/data 0755 jellyfin jellyfin -"
    "d /persist/jellyfin/cache 0755 jellyfin jellyfin -"
  ];

  # Bind mount Jellyfin data to persistent storage
  fileSystems."/var/lib/jellyfin" = {
    device = "/persist/jellyfin";
    options = [ "bind" ];
  };

  # Prevent sleep when lid closed (server use)
  services.logind = {
    lidSwitch = "ignore";
    lidSwitchExternalPower = "ignore";
  };

  # Power management for 24/7 use
  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
}
