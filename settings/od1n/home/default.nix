{
  inputs,
  outputs,
  config,
  lib,
  flakePath,
  ...
}: {
  imports = [
    # Import home-manager's NixOS module
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    # Synch with our nixos' pkgs
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs outputs flakePath;};
    users = {
      # Import your home-manager configuration
      ${config.userSettings.username} = {
        imports = [
          ../../../home/default.nix
          ../../options/default.nix
          ../config.nix
          ../../../themes/image_store/od1n.nix
        ];

        home = {
          username = config.userSettings.username;
          homeDirectory = lib.mkForce "/home/${config.userSettings.username}";
          # Specify additional outputs to install, such as documentation
          extraOutputsToInstall = ["doc" "devdoc"];

          # The initial version of Home Manager ration, should not be changed after set
          stateVersion = "24.05";
        };
      };
    };
  };
}
