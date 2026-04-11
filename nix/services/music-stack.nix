# Local music acquisition stack for desktop
#
# Architecture:
#   Aurral (requests) → Prowlarr (indexers) → Lidarr (manager) → qBittorrent → Beets → MPD
#
# Ports:
#   - Aurral:      3001 (request UI)
#   - Prowlarr:    9696 (indexer manager)
#   - Lidarr:      8686 (music management UI)
#   - qBittorrent: 8085 (torrent client WebUI)
#
# Post-install configuration:
#   1. Prowlarr (http://localhost:9696):
#      - Add indexers (torrent sites for music)
#      - Settings → Apps → Add Lidarr (sync indexers automatically)
#   2. Lidarr (http://localhost:8686):
#      - Settings → Download Clients → Add qBittorrent (host: localhost, port: 8085)
#      - Settings → Media Management → Root folder: /home/<user>/Media/Music
#      - Settings → Media Management → Enable "Use Hardlinks instead of Copy"
#   3. qBittorrent (http://localhost:8085):
#      - Default login: admin / adminadmin (change immediately)
#      - Settings → Downloads → Default Save Path: /home/<user>/Media/Downloads/music
#   4. Aurral (http://localhost:3001):
#      - Settings → Integrations → Lidarr:
#        - URL: http://localhost:8686
#        - API Key: (from Lidarr Settings → General)
#      - Settings → Integrations → Last.fm (optional):
#        - API Key from https://www.last.fm/api/account/create
#      - Settings → Integrations → MusicBrainz:
#        - Contact email (required for API)
#
# Beets integration:
#   - Configured via home-manager (see home/programs/beets)
#   - Run `beet import /path/to/downloads` to organize new music
#   - Or configure Lidarr to run beets as a post-import script
#
# Directory structure:
#   ~/Media/
#   ├── Music/           (Lidarr root folder, MPD music directory)
#   └── Downloads/
#       └── music/       (qBittorrent download location for music)
{
  config,
  pkgs,
  lib,
  ...
}:
let
  isEnabled = builtins.elem config.systemSettings.profile [ "gaming" "personal" ];
  username = config.userSettings.username;
  musicDir = "/home/${username}/Media/Music";
  downloadsDir = "/home/${username}/Media/Downloads/music";
  aurralDataDir = "/home/${username}/.local/share/aurral";
in
{
  # Prowlarr - indexer manager (syncs indexers to Lidarr)
  services.prowlarr = {
    enable = isEnabled;
    openFirewall = true;
  };

  # Lidarr - music collection manager
  services.lidarr = {
    enable = isEnabled;
    openFirewall = true;
    user = username;
    group = "users";
    dataDir = "/home/${username}/.config/lidarr";
    settings = {
      server.port = 8686;
      log.analyticsEnabled = false;
    };
  };

  # qBittorrent - torrent client (local instance for music)
  services.qbittorrent = lib.mkIf isEnabled {
    enable = true;
    webuiPort = 8085;
    openFirewall = true;
  };

  # Add qbittorrent user to user's group for file access
  users.users.qbittorrent.extraGroups = lib.mkIf isEnabled [ "users" ];

  # Create directories (~/Media/Music is created by XDG userDirs)
  systemd.tmpfiles.rules = lib.mkIf isEnabled [
    "d ${downloadsDir} 0755 ${username} users -"
    "d ${aurralDataDir} 0755 ${username} users -"
    "d ${aurralDataDir}/downloads 0755 ${username} users -"
  ];

  # Aurral - music request UI (Jellyseerr-like for Lidarr)
  virtualisation.oci-containers = lib.mkIf isEnabled {
    backend = "podman";
    containers.aurral = {
      image = "ghcr.io/lklynet/aurral:latest";
      ports = [ "3001:3001" ];
      volumes = [
        "${aurralDataDir}:/app/backend/data"
        "${aurralDataDir}/downloads:/app/downloads"
      ];
      extraOptions = [
        "--add-host=host.containers.internal:host-gateway"
      ];
    };
  };
}
