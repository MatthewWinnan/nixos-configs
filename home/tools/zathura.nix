{
  programs.zathura = {
    enable = true;
    options = {
      font = "SF Pro Text 15"; # Sets the font used in the UI to SF Pro Text with size 15.
      selection-clipboard = "clipboard"; # Enables copying selected text to the clipboard.
      adjust-open = "best-fit"; # Adjusts the document to fit the window when opened.
      pages-per-row = "1"; # Sets the number of pages displayed per row to 1.
      scroll-page-aware = "true"; # Enables page-aware scrolling, stopping at page boundaries.
      scroll-full-overlap = "0.01"; # Sets the overlap when scrolling a full page to 1% of the page height.
      scroll-step = "100"; # Sets the number of pixels to scroll with each step.
      smooth-scroll = true; # Enables smooth scrolling.
      zoom-min = "10"; # Sets the minimum zoom level to 10%.
      guioptions = "none"; # Disables additional GUI elements.
      statusbar-h-padding = "0"; # Sets horizontal padding of the status bar to 0.
      statusbar-v-padding = "0"; # Sets vertical padding of the status bar to 0.
      page-padding = "1"; # Sets padding between pages to 1 pixel.
      recolor = "true"; # Enables recoloring of documents.
    };
    mappings = {
      u = "scroll half-up";
      d = "scroll half-down";
      D = "toggle_page_mode";
      r = "reload";
      R = "rotate";
      K = "zoom in";
      J = "zoom out";
      i = "recolor";
      p = "print";
      g = "goto top";

      # Custom mappings for fullscreen mode.
      "[fullscreen] u" = "scroll half-up";
      "[fullscreen] d" = "scroll half-down";
      "[fullscreen] D" = "toggle_page_mode";
      "[fullscreen] r" = "reload";
      "[fullscreen] R" = "rotate";
      "[fullscreen] K" = "zoom in";
      "[fullscreen] J" = "zoom out";
      "[fullscreen] i" = "recolor";
      "[fullscreen] p" = "print";
      "[fullscreen] g" = "goto top";
    };
  };
}
