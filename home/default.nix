{config, lib, ...}:{
  imports = [
    ./tools/default.nix
    ./desktop/default.nix
    ./programs/schizofox/default.nix
    ../themes/gtk.nix
  ];
}
