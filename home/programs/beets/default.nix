# Beets - music library organizer and tagger
# https://beets.readthedocs.io/
#
# Usage:
#   beet import ~/Media/Downloads/music    # Import and organize new music
#   beet ls                                  # List library
#   beet info <query>                        # Show track info
#   beet modify <query> artist=X             # Modify tags
#   beet update                              # Update library after manual changes
#
# Integration with Lidarr:
#   Configure Lidarr to use beets as import script, or manually run
#   `beet import` on downloaded music before it moves to the library.
{
  pkgs,
  config,
  ...
}:
let
  isEnabled = builtins.elem config.systemSettings.profile [ "gaming" "personal" ];
  username = config.userSettings.username;
  musicDir = "/home/${username}/Media/Music";
in
{
  programs.beets = {
    enable = isEnabled;

    # Enable MPD integration
    mpdIntegration = {
      enableUpdate = true;  # Auto-update MPD database after import
      enableStats = true;   # Track play statistics
      host = "127.0.0.1";
      port = 6600;
    };

    settings = {
      # Library location
      directory = musicDir;
      library = "/home/${username}/.config/beets/library.db";

      # Import settings
      import = {
        move = true;           # Move files instead of copy
        write = true;          # Write tags to files
        copy = false;
        incremental = true;    # Skip already-imported
        quiet_fallback = "skip";
        log = "/home/${username}/.config/beets/import.log";
      };

      # Path format for organized music
      paths = {
        default = "$albumartist/$album%aunique{}/$track $title";
        singleton = "Non-Album/$artist/$title";
        comp = "Compilations/$album%aunique{}/$track $title";
      };

      # Plugins
      plugins = [
        "fetchart"      # Fetch album art
        "embedart"      # Embed art in files
        "lastgenre"     # Fetch genres from Last.fm
        "scrub"         # Clean up tags
        "replaygain"    # Calculate replay gain
        "duplicates"    # Find duplicate tracks
        "missing"       # Find missing tracks in albums
        "mpdstats"      # MPD play statistics
        "mpdupdate"     # Update MPD on import
      ];

      # Album art settings
      fetchart = {
        auto = true;
        minwidth = 300;
        sources = [ "filesystem" "coverart" "itunes" "amazon" ];
      };

      embedart = {
        auto = true;
        remove_art_file = false;  # Keep external art file too
      };

      # Last.fm genre fetching
      lastgenre = {
        auto = true;
        count = 3;  # Number of genres to fetch
      };

      # ReplayGain
      replaygain = {
        backend = "ffmpeg";
        auto = true;
      };
    };
  };
}
