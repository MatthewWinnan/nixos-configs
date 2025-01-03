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
    himalaya.url = "github:pimalaya/himalaya";
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

    # To help with package searching and indexing
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    # For secrets management
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # This will provide us with the latest version of the
    # vscode extensions.
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    # Nix Formatter
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Needed for my Legion Y530-15ICH
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Needed for zephyr development see -> https://github.com/adisbladis/zephyr-nix/tree/master
    zephyr.url = "github:zephyrproject-rtos/zephyr/v3.5.0";
    zephyr.flake = false;

    zephyr-nix = {
      url = "github:adisbladis/zephyr-nix";
      inputs = {
          nixpkgs.follows = "nixpkgs";
          zephyr.follows = "zephyr";
      };
    };
  };

  outputs = { self, alejandra, nixpkgs, zephyr-nix, nixpkgs-stable, stylix, home-manager, manga-tui, schizofox, nix-index-database, sops-nix, nix-vscode-extensions, himalaya, nixos-hardware, ... }@inputs:

    let
      system = "x86_64-linux";
      flakePath = toString ./.;  # This is the path to the flake's director
      lib = nixpkgs.lib // home-manager.lib;
      pkgs_pkgs = import nixpkgs { inherit system; };
      zephyr = zephyr-nix.packages.x86_64-linux;
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

    # ba1dr - Old Lenovo Legion (Legion Y530-15ICH), using it for gaming and development
    nixosConfigurations.ba1dr = nixpkgs.lib.nixosSystem {
      specialArgs = {
        pkgs-stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
        inherit inputs system flakePath;
      };
        modules = [
          nixos-hardware.nixosModules.lenovo-legion-y530-15ich
          ./gaming/ba1dr/default.nix

          # For this one just directly import not sure if worth making conditionals in nixos/nix_config.nix
          ./nix/gaming/default.nix

          ./settings/ba1dr/nixos/nix_config.nix
          ./settings/ba1dr/home/default.nix
        ];
      };

    devShells.x86_64-linux = import ./shells/default.nix {
        pkgs = import nixpkgs {
          system = system;
        };
        system = system;
        lib = lib;
        stdenvNoCC = nixpkgs.legacyPackages.${system}.stdenvNoCC;
        runCommand = nixpkgs.runCommand;
        fetchgit = pkgs_pkgs.fetchgit;
        zephyr = zephyr;
    };

    };

}
