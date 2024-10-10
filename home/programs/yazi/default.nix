# https://yazi-rs.github.io/docs/
# https://yazi-rs.github.io/docs/configuration/yazi/ -> this is for configuration spcififcally
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

    enableFishIntegration = true;

    settings = {
      manager = {
        layout = [1 4 3];
        sort_by = "alphabetical";
        sort_sensitive = true;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "none";
        show_hidden = true;
        show_symlink = true;
      };

      preview = {
        tab_size = 2;
        max_width = 600;
        max_height = 900;
        cache_dir = "${config.xdg.cacheHome}/yazi";
      };
    };
  };
}
