{

  imports = [
    ./opts.nix
    ./keymaps.nix
    ./autocmds.nix
    ./plugins/plugins-bundle.nix
  ];

  programs.nixvim = {
    enable = true;

    defaultEditor = true;
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavor = "macchiato";
      };
    };
    # colorschemes.oxocarbon.enable = true;
  };
}
