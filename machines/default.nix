{ inputs, ... }:
let
  # Defaults
  system = "x86_64-linux";
  host_platform = {
    nixpkgs.hostPlatform = system;
  };

  # Imports
  lenovo_legion = inputs.nixos-hardware.nixosModules.lenovo-legion-y530-15ich;
  raspberry_pi_4 = inputs.nixos-hardware.nixosModules.raspberry-pi-4;
  nixvim = inputs.nixvim.nixosModules.nixvim;
  stylix = inputs.stylix.nixosModules.stylix;
  nix-index = inputs.nix-index-database.nixosModules.nix-index;
  hm = inputs.home-manager.nixosModules.home-manager;
  wsl = inputs.nixos-wsl.nixosModules.wsl;
  sops = inputs.sops-nix.nixosModules.sops;
in
{
  # th0r - lattepanda delta for home lab use
  # headless
  th0r = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
    };
    modules = [
      # General inputs
      host_platform
      nixvim
      nix-index

      # Remaining modules
      ./th0r
    ];
  };

  # fr3yr - Raspberry Pi 4 running Home Assistant
  # headless
  fr3yr = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
    };
    modules = [
      # General inputs
      { nixpkgs.hostPlatform = "aarch64-linux"; }
      nixvim
      nix-index
      sops

      # Raspberry Pi 4 hardware support
      raspberry_pi_4

      # Remaining modules
      ./fr3yr
    ];
  };

  # m1m1r - proxmox VM running on Odroid H3+
  # headless
  m1m1r = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
    };
    modules = [
      # General inputs
      host_platform
      nixvim
      nix-index

      # Remaining modules
      ./m1m1r
    ];
  };

  # ba1dr - Old Lenovo Legion (Legion Y530-15ICH), using it for gaming and development
  ba1dr = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
    };
    modules = [
      # General inputs
      host_platform
      nixvim
      stylix
      nix-index
      hm

      # Specific hardware compat features
      lenovo_legion

      # Remaining modules
      ./ba1dr
    ];
  };

  # h31mda11 - Desktop Computer Used For Gaming
  h31mda11 = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
    };
    modules = [
      # General inputs
      host_platform
      nixvim
      stylix
      nix-index
      hm
      sops

      # Remaining modules
      ./h31mda11
    ];
  };

  # od1n - T580 for coding use
  od1n = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
    };
    modules = [
      # General inputs
      host_platform
      nixvim
      stylix
      nix-index
      hm

      # Remaining modules
      ./od1n
    ];
  };

  # fafn1r used for work
  fafn1r = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
    };
    modules = [
      # General inputs
      host_platform
      nixvim
      stylix
      nix-index
      hm

      # Remaining modules
      ./fafn1r
    ];
  };

  # My WSL laptop
  nixos = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
    };
    modules = [
      # General inputs
      host_platform
      nixvim
      nix-index
      stylix
      wsl

      # Remaining modules
      ./nixos
    ];
  };
}
