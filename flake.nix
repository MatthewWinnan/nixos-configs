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

    # Browse manga
    manga-tui.url = "github:josueBarretogit/manga-tui";

    # Schizophrenic Firefox configuration
    schizofox = {
      url = "github:schizofox/schizofox";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

  };

  outputs = { self, nixpkgs, nixpkgs-stable, stylix, home-manager, manga-tui, schizofox, ... }@inputs:

    let
      system = "x86_64-linux";
      flakePath = toString ./.;  # This is the path to the flake's director
      lib = nixpkgs.lib // home-manager.lib;
    in {
      inherit lib;

    # th0r - lattepanda delta for home lab use
    nixosConfigurations.th0r = nixpkgs.lib.nixosSystem {
      specialArgs = {
        pkgs-stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
        inherit inputs system flakePath;
      };
        modules = [
          ./settings/th0r/nixos/nix_config.nix
          ./settings/th0r/home/default.nix
        ];
      };

    # od1n - T580 for coding use
    nixosConfigurations.od1n = nixpkgs.lib.nixosSystem {
      specialArgs = {
        pkgs-stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
        inherit inputs system flakePath;
      };
        modules = [
          ./settings/od1n/nixos/nix_config.nix
          ./settings/od1n/home/default.nix
        ];
      };

    };

}
