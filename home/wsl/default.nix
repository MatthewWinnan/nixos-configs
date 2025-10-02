{
  config,
  lib,
  ...
}: {
  imports = [
    ../tools/default.nix
    ../programs/default.nix
    ../../themes/gtk.nix
    ./services.nix
    ../shell/default.nix
    ../terminal/default.nix
  ];
}
