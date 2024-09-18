{config, lib, ...}:{
  imports = [
    ./tools/default.nix
    ./desktop/default.nix
    ./programs/schizofox/default.nix
    ./programs/vscode/default.nix
    ../themes/gtk.nix
  ];
}
