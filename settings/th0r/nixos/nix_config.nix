{
  config,
  pkgs,
  inputs,
  flakePath,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../../nix/default.nix
    inputs.nixvim.nixosModules.nixvim
    inputs.stylix.nixosModules.stylix
    inputs.nix-index-database.nixosModules.nix-index
    ../../options/default.nix
    ../config.nix
    ../../../themes/image_store/th0r.nix
  ];
}
