{ inputs, outputs, config, lib, flakePath, ... }: {
  imports = [
    # Import home-manager's NixOS module
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs flakePath; };
    users = {
      # Import your home-manager configuration
      ${config.userSettings.username} = {
        imports = [./${config.systemSettings.hostname}/default.nix
          ../settings/options/default.nix
          ../settings/${config.systemSettings.hostname}/config.nix

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
