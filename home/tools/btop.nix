# Options -> https://mynixos.com/home-manager/options/programs.btop
# Basing it off of -> https://github.com/end-4/dots-hyprland/blob/archive/hybrid-summer/.config/btop/btop.conf#LL8
{
  programs.btop = {
    enable = true;
    settings = {
      # If the theme set background should be shown, set to False if you want terminal background transparency.
      theme_background = false;

      # Set to True to enable "h,j,k,l,g,G" keys for directional control in lists.
      #Conflicting keys for h:"help" and k:"kill" is accessible while holding shift.
      vim_keys = true;

      # Rounded corners on boxes, is ignored if TTY mode is ON.
      rounder_corners = true;

      # Default symbols for graph creation
      graph_symbol = "braille";
    };
  };
}
