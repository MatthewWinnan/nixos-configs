# https://yazi-rs.github.io/docs/
# https://yazi-rs.github.io/docs/configuration/yazi/ -> this is for configuration spcififcally
# https://mynixos.com/home-manager/options/programs.yazi
{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./theme
  ];

  home.packages = with pkgs; [
    exiftool
    glow # markdown preview for glow plugin
  ];

  programs.yazi = {
    enable = true;
    shellWrapperName = "y";

    # List off of our shell integrations here
    enableZshIntegration = config.programs.zsh.enable;
    enableBashIntegration = config.programs.bash.enable;
    enableNushellIntegration = config.programs.nushell.enable;
    enableFishIntegration = config.programs.fish.enable;

    plugins = with pkgs.yaziPlugins; {
      # Existing
      duckdb = duckdb;
      mediainfo = mediainfo;
      # Visual
      full-border = full-border;
      starship = starship;
      # Git
      git = git;
      lazygit = lazygit;
      # Navigation
      smart-enter = smart-enter;
      jump-to-char = jump-to-char;
      relative-motions = relative-motions;
      bookmarks = bookmarks;
      # File operations
      chmod = chmod;
      compress = compress;
      diff = diff;
      # Previews
      glow = glow;
      rich-preview = rich-preview;
    };

    initLua = ''
      -- full-border
      require("full-border"):setup()
      -- starship prompt in header
      require("starship"):setup()
      -- git status in file list
      require("git"):setup()
      -- relative motions
      require("relative-motions"):setup({ show_numbers = "relative_absolute", show_motion = true })
      -- bookmarks
      require("bookmarks"):setup({ persist = "all" })
    '';

    keymap = {
      mgr.prepend_keymap = [
        # smart-enter: open files, enter directories
        { on = ["l"]; run = "plugin smart-enter"; desc = "Enter or open"; }
        { on = ["<Enter>"]; run = "plugin smart-enter"; desc = "Enter or open"; }
        # jump-to-char
        { on = ["f"]; run = "plugin jump-to-char"; desc = "Jump to char"; }
        # relative motions (1-9)
        { on = ["1"]; run = "plugin relative-motions -- 1"; desc = "Move 1 line"; }
        { on = ["2"]; run = "plugin relative-motions -- 2"; desc = "Move 2 lines"; }
        { on = ["3"]; run = "plugin relative-motions -- 3"; desc = "Move 3 lines"; }
        { on = ["4"]; run = "plugin relative-motions -- 4"; desc = "Move 4 lines"; }
        { on = ["5"]; run = "plugin relative-motions -- 5"; desc = "Move 5 lines"; }
        { on = ["6"]; run = "plugin relative-motions -- 6"; desc = "Move 6 lines"; }
        { on = ["7"]; run = "plugin relative-motions -- 7"; desc = "Move 7 lines"; }
        { on = ["8"]; run = "plugin relative-motions -- 8"; desc = "Move 8 lines"; }
        { on = ["9"]; run = "plugin relative-motions -- 9"; desc = "Move 9 lines"; }
        # bookmarks
        { on = ["m"]; run = "plugin bookmarks -- save"; desc = "Save bookmark"; }
        { on = ["'"]; run = "plugin bookmarks -- jump"; desc = "Jump to bookmark"; }
        { on = ["b" "d"]; run = "plugin bookmarks -- delete"; desc = "Delete bookmark"; }
        { on = ["b" "D"]; run = "plugin bookmarks -- delete_all"; desc = "Delete all bookmarks"; }
        # chmod
        { on = ["c" "m"]; run = "plugin chmod"; desc = "Chmod selected files"; }
        # compress
        { on = ["c" "a"]; run = "plugin compress"; desc = "Compress selected files"; }
        # diff
        { on = ["c" "d"]; run = "plugin diff"; desc = "Diff selected files"; }
        # lazygit
        { on = ["c" "g"]; run = "plugin lazygit"; desc = "Open lazygit"; }
        # glow markdown preview
        { on = ["c" "p"]; run = "plugin glow"; desc = "Preview markdown with glow"; }
      ];
    };

    settings = {
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

      plugin = {
        prepend_previewers = [
          { mime = "text/markdown"; run = "glow"; }
        ];
        prepend_preloaders = [
          { mime = "text/markdown"; run = "glow"; }
        ];
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
