{config, pkgs, inputs, flakePath, ...}:{

  imports = [
    ./hardware-configuration.nix
    ../../../nix/default.nix
    inputs.nixvim.nixosModules.nixvim
    inputs.stylix.nixosModules.stylix
    ../../options/default.nix
    ../config.nix
  ];

}
