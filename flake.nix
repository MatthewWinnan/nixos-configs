{
  description = "My Homelab Configuration";

  inputs = {
    # Just so I can swap between versions that I know works
    nixpkgs-24-05.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    # I generally keep with the unstable when possible
    # For now pin it to stable since new unstable is too fresh (June 4 2025)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    swww = {
      url = "github:LGFae/swww";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    himalaya = {
      url = "github:pimalaya/himalaya";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Fetches some of the anyrun plugins
    # Fork for examples?
    # https://github.com/anyrun-org/anyrun
    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Browse manga
    manga-tui = {
      url = "github:josueBarretogit/manga-tui";
    };

    # For movie viewing
    lobster = {
      url = "github:justchokingaround/lobster";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    # Nix helper, need to keep it newer than the current nixpkgs
    nh = {
      url = "github:nix-community/nh/master";
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
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    # Needed for zephyr development see -> https://github.com/adisbladis/zephyr-nix/tree/master
    zephyr = {
      url = "github:zephyrproject-rtos/zephyr/v3.5.0";
      flake = false;
    };
    zephyr-nix = {
      url = "github:adisbladis/zephyr-nix";
      inputs = {
        # Need to pint it to nixpkgs stable since this is the last point in time it worked...
        nixpkgs.follows = "nixpkgs-stable";
        zephyr.follows = "zephyr";
      };
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    # Modular import to allow for all systems
    forAllSystemsInputs = function: nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (system: function inputs system);
  in {
    # Formatter of choice
    formatter = forAllSystemsInputs (inputs: system: inputs.alejandra.defaultPackage.${system});

    # My own local devshells
    devShells = forAllSystemsInputs (inputs: system: import ./shells {inherit system inputs;});

    # NixOS machine configurations, now modular
    nixosConfigurations = import ./machines {inherit inputs;};
  };
}
