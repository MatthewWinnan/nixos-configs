# Media automation stack (the "arr" suite)
#
# Architecture:
#   Jellyseerr (requests) → Radarr/Sonarr → Prowlarr (indexers) → qBittorrent (download)
#                                    ↓
#                              Jellyfin (library)
#                                    ↑
#                              Bazarr (subtitles)
#
#   Readarr (books) → Prowlarr (indexers) → qBittorrent (download)
#               ↓
#          Calibre (library)
#               ↓
#          Calibre-Web (reading UI)
#
# Ports:
#   - Jellyseerr:  5055 (request UI)
#   - Radarr:      7878 (movies)
#   - Sonarr:      8989 (TV shows)
#   - Prowlarr:    9696 (indexer manager)
#   - Bazarr:      6767 (subtitles)
#   - qBittorrent: 8085 (torrent client WebUI)
#   - Readarr:     8787 (books/audiobooks)
#   - Calibre-Web: 8083 (book reading UI)
#
# Post-install configuration required:
#   1. Prowlarr (http://localhost:9696):
#      - Add indexers (torrent sites + Libgen/Audiobookbay for books)
#   2. Radarr (http://localhost:7878):
#      - Settings → Indexers → Add Prowlarr
#      - Settings → Download Clients → Add qBittorrent (port 8085)
#      - Settings → Media Management → Root folder: /media/movies
#   3. Sonarr (http://localhost:8989):
#      - Same as Radarr, root folder: /media/tv
#   4. Bazarr (http://localhost:6767):
#      - Settings → Sonarr/Radarr → Connect to both
#   5. Jellyseerr (http://localhost:5055):
#      - Connect to Jellyfin
#      - Connect to Radarr and Sonarr
#   6. Readarr (http://localhost:8787):
#      - Settings → Indexers → Add Prowlarr
#      - Settings → Download Clients → Add qBittorrent (port 8085)
#      - Settings → Media Management → Root folder: /media/books
#      - Settings → Media Management → Calibre: http://localhost:8083
#   7. Calibre-Web (http://localhost:8083):
#      - Point to Calibre library at /media/books
#      - Enable upload for Readarr integration
#
# Media directory structure:
#   /media/
#   ├── movies/      (Radarr root folder)
#   ├── tv/          (Sonarr root folder)
#   ├── books/       (Readarr root folder / Calibre library)
#   └── downloads/   (qBittorrent download location)
{pkgs, ...}: let
  # Shared media group for all services
  mediaGroup = "media";

  # Media directories
  mediaDir = "/media";
  moviesDir = "${mediaDir}/movies";
  tvDir = "${mediaDir}/tv";
  booksDir = "${mediaDir}/books";
  downloadsDir = "${mediaDir}/downloads";
in {
  users = {
    groups.${mediaGroup} = {};
    users.qbittorrent.extraGroups = [mediaGroup];
    users.jellyfin.extraGroups = [mediaGroup];
  };

  services = {
    # qBittorrent - torrent client
    qbittorrent = {
      enable = true;
      webuiPort = 8085; # Avoid conflict with other services
      openFirewall = true;
    };

    # Prowlarr - indexer manager
    prowlarr = {
      enable = true;
      openFirewall = true;
    };

    # Radarr - movie management
    radarr = {
      enable = true;
      openFirewall = true;
      group = mediaGroup;
    };

    # Sonarr - TV show management
    sonarr = {
      enable = true;
      openFirewall = true;
      group = mediaGroup;
    };

    # Bazarr - subtitle management
    bazarr = {
      enable = true;
      openFirewall = true;
      group = mediaGroup;
    };

    # Jellyseerr - request management UI
    jellyseerr = {
      enable = true;
      openFirewall = true;
    };

    # Readarr - book and audiobook management
    readarr = {
      enable = true;
      openFirewall = true;
      group = mediaGroup;
    };

    # Calibre-Web - book reading UI backed by Calibre library
    calibre-web = {
      enable = true;
      openFirewall = true;
      group = mediaGroup;
      listen = {
        ip = "0.0.0.0";
        port = 8083;
      };
      options = {
        calibreLibrary = booksDir;
        enableBookUploading = true;
      };
    };
  };

  systemd = {
    services = {
      qbittorrent.serviceConfig.UMask = "0002";
      radarr.serviceConfig.UMask = "0002";
      sonarr.serviceConfig.UMask = "0002";
      readarr.serviceConfig.UMask = "0002";

      # Initialise the Calibre library (metadata.db) if it doesn't exist yet.
      # Calibre-Web refuses to start without a valid library so this must run first.
      calibre-web = {
        requires = ["calibre-library-init.service"];
        after = ["calibre-library-init.service"];
      };

      calibre-library-init = {
        description = "Initialise Calibre library metadata.db";
        before = ["calibre-web.service"];
        wantedBy = ["calibre-web.service"];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          User = "calibre-web";
          Group = mediaGroup;
        };
        script = ''
          if [ ! -f "${booksDir}/metadata.db" ]; then
            ${pkgs.calibre}/bin/calibredb list --library-path "${booksDir}" > /dev/null
            echo "Calibre library initialised at ${booksDir}"
          fi
        '';
      };
    };

    # Create media directories with proper permissions
    tmpfiles.rules = [
      "d ${mediaDir} 0775 root ${mediaGroup} -"
      "d ${moviesDir} 0775 root ${mediaGroup} -"
      "d ${tvDir} 0775 root ${mediaGroup} -"
      "d ${booksDir} 0775 root ${mediaGroup} -"
      "d ${downloadsDir} 0775 root ${mediaGroup} -"
    ];
  };
}
