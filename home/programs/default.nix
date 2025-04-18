{config, ...}: {
  imports = [
    ./newsboat/default.nix
    ./schizofox/default.nix
    ./vscode/default.nix
    ./yazi/default.nix
    ./direnv.nix
  ];
}
