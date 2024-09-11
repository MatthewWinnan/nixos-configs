{
  description = "My system configuration";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    swww.url = "github:LGFae/swww";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, stylix, home-manager, ... }@inputs:

    let
      system = "x86_64-linux";
      flakePath = toString ./.;  # This is the path to the flake's director
      lib = nixpkgs.lib // home-manager.lib;
    in {
    inherit lib;
    # th0r - system hostname
    nixosConfigurations.th0r = nixpkgs.lib.nixosSystem {
      specialArgs = {
        pkgs-stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
        inherit inputs system flakePath;
      };
        modules = [
          ./settings/th0r/nix_config.nix
          ./home/default.nix
        ];
      };

    };

}
