# https://yazi-rs.github.io/docs/
# https://yazi-rs.github.io/docs/configuration/yazi/ -> this is for configuration spcififcally
# https://mynixos.com/home-manager/options/programs.yazi
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./theme
  ];

  home.packages = [pkgs.exiftool];

  programs.yazi = {
    enable = true;

    # List off of our shell integrations here
    enableZshIntegration = config.programs.zsh.enable;
    enableBashIntegration = config.programs.bash.enable;
    enableNushellIntegration = config.programs.nushell.enable;
    enableFishIntegration = config.programs.fish.enable;

    plugins = {
      # https://github.com/wylie102/duckdb.yazi
      duckdb = pkgs.yaziPlugins.duckdb;
      # https://github.com/boydaihungst/mediainfo.yazi
      mediainfo = pkgs.yaziPlugins.mediainfo;
    };

    settings = {
      # `[manager]` has been deprecated in favor of the new `[mgr]`, see #2803 for more details: https://github.com/sxyazi/yazi/pull/2803
      mgr = {
        layout = [1 4 3];
        sort_by = "alphabetical";
        sort_sensitive = true;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "mtime";
        show_hidden = true;
        show_symlink = true;
      };

      preview = {
        tab_size = 2;
        max_width = 600;
        max_height = 900;
        cache_dir = "${config.xdg.cacheHome}/yazi";
      };

      opener = {
        pdf = [
          { run = ''sioyek "$@"''; desc = "Open with Sioyek"; orphan = true; }
        ];
        image = [
          { run = ''imv "$@"''; desc = "Open with imv"; orphan = true; }
        ];
        markdown = [
          { run = ''typora "$@"''; desc = "Open with Typora"; orphan = true; }
        ];
        fallback = [
          { run = ''evince "$@"''; desc = "Open with Evince"; orphan = true; }
        ];
        edit = [
          { run = ''$EDITOR "$@"''; block = true; desc = "Edit in $EDITOR"; }
        ];
      };

      open = {
        rules = [
          { mime = "application/pdf"; use = "pdf"; }
          { mime = "image/*"; use = "image"; }
          { mime = "text/markdown"; use = "markdown"; }
          { mime = "text/x-markdown"; use = "markdown"; }
          { name = "*.md"; use = "markdown"; }
          { mime = "application/epub+zip"; use = "fallback"; }
          { mime = "application/postscript"; use = "fallback"; }
          { mime = "image/vnd.djvu"; use = "fallback"; }
          { mime = "text/*"; use = "edit"; }
        ];
      };
    };
  };
}
