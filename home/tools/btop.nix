# Options -> https://mynixos.com/home-manager/options/programs.btop
# Basing it off of -> https://github.com/end-4/dots-hyprland/blob/archive/hybrid-summer/.config/btop/btop.conf#LL8
{
  programs.btop = {
    enable = true;
    settings = {
      # If the theme set background should be shown, set to False if you want terminal background transparency.
      theme_background = false;

      # Set to True to enable "h,j,k,l,g,G" keys for directional control in lists.
      # Conflicting keys for h:"help" and k:"kill" is accessible while holding shift.
      vim_keys = true;

      # Rounded corners on boxes, is ignored if TTY mode is ON.
      rounded_corners = true;

      # Default symbols for graph creation
      graph_symbol = "braille";

      # Prettier process tree
      proc_tree = true;
      proc_gradient = true;
      proc_per_core = false;

      # Show CPU temp and graph
      show_coretemp = true;
      temp_scale = "celsius";
      cpu_graph_upper = "total";
      cpu_graph_lower = "total";

      # Show battery stats if available
      show_battery = true;

      # Show disk IO activity
      show_io_stat = true;
      io_mode = false;

      # Network graph auto-scaling
      net_auto = true;
    };
  };
}
