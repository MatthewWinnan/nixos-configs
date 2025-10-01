{inputs, ...}: let
  # Defaults
  system = "x86_64-linux";
  host_platform = {nixpkgs.hostPlatform = system;};

  # Imports
  lenovo_legion = inputs.nixos-hardware.nixosModules.lenovo-legion-y530-15ich;
  nixvim = inputs.nixvim.nixosModules.nixvim;
  stylix = inputs.stylix.nixosModules.stylix;
  nix-index = inputs.nix-index-database.nixosModules.nix-index;
  hm = inputs.home-manager.nixosModules.home-manager;
in {
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

  # l0k1 used for work
  l0k1 = inputs.nixpkgs.lib.nixosSystem {
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
      ./l0k1
    ];
  };
}
