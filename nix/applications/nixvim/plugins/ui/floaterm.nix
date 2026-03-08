# https://nix-community.github.io/nixvim/plugins/floaterm/settings.html
# We need to always remember to consult the docs, naming has changed
{
  programs.nixvim.plugins.floaterm = {
    enable = true;

    settings = {
      title = "";
      height = 0.8;
      width = 0.8;
      keymap_toggle = "<C-b>";
    };
  };
}
