{config, lib, ...}:{
  imports = [
    ./tools/default.nix
    ./desktop/default.nix
    ./programs/schizofox/default.nix
    ./programs/vscode/default.nix
    ./programs/yazi/default.nix
    ./programs/newsboat/default.nix
    ../themes/gtk.nix
    ./services/default.nix
  ];
}
