{pkgs, ...}: {
  programs.sioyek = {
    enable = true;
    package = pkgs.sioyek.overrideAttrs (old: {
      nativeBuildInputs = (old.nativeBuildInputs or []) ++ [pkgs.makeWrapper];
      postFixup =
        (old.postFixup or "")
        + ''
          wrapProgram $out/bin/sioyek \
            --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath [pkgs.pipewire pkgs.libGL pkgs.mesa]}"
        '';
    });
    config = {
      # Dark mode - matches zathura recolor preference
      default_dark_mode = "1";
      dark_mode_contrast = "0.85";

      # UI settings - minimal like zathura
      should_load_tutorial_when_no_other_file = "0";
      should_launch_new_window = "0";
      flat_toc = "1";

      # Scrolling - smooth and consistent with zathura
      smooth_scroll_speed = "3.0";
      smooth_scroll_drag = "2500";
      touchpad_sensitivity = "1.0";
      vertical_move_amount = "1.0";
      horizontal_move_amount = "1.0";

      # Zoom settings
      zoom_inc_factor = "1.2";
      wheel_zoom_on_cursor = "1";

      # Search engines for research
      search_url_s = "https://scholar.google.com/scholar?q=";
      search_url_l = "https://libgen.is/search.php?req=";
      search_url_g = "https://www.google.com/search?q=";

      # Startup command to fit width
      startup_commands = "fit_to_page_width";
    };
    bindings = {
      # Half-page scrolling like zathura (u/d)
      move_up = "u";
      move_down = "d";

      # Full screen scrolling
      screen_up = "<C-u>";
      screen_down = "<C-d>";

      # Zoom with J/K like zathura
      zoom_out = "J";
      zoom_in = "K";

      # Navigation
      goto_beginning = "gg";
      goto_end = "G";
      next_page = "j";
      previous_page = "k";

      # Rotate like zathura
      rotate_clockwise = "R";
      rotate_counterclockwise = "<S-R>";

      # Dark mode toggle (like zathura's recolor)
      toggle_dark_mode = "i";

      # Utility
      reload = "r";
      fit_to_page_width = "w";
      fit_to_page_height = "h";
      fit_to_page_width_smart = "e";

      # Table of contents
      goto_toc = "t";

      # Search
      search = "/";
      next_item = "n";
      previous_item = "N";

      # Bookmarks and highlights
      add_bookmark = "b";
      delete_bookmark = "db";
      add_highlight = "m";
      delete_highlight = "dm";
      goto_bookmark = "gb";
      goto_highlight = "gm";

      # Portal/link following (sioyek's unique feature)
      portal = "p";
      delete_portal = "dp";

      # Quick open
      open_document = "o";
      open_prev_doc = "<C-o>";

      # Copy
      copy = "y";

      # Quit
      quit = "q";
    };
  };
}
