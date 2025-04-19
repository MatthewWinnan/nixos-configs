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
  th0r = inputs.nixpkgs.lib.nixosSystem {
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
      ./th0r
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
}
