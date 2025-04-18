{
  config,
  lib,
  ...
}: {
  imports = [
    ./tools/default.nix
    ./desktop/default.nix
    ./programs/default.nix
    ../themes/gtk.nix
    ./services/default.nix
    ./shell/default.nix
    ./terminal/default.nix
  ];
}
