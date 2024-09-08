{pkgs, lib, config, ...}:{
  imports = [
    ../../home/default.nix
    ./config.nix
  ];


home = {
        username = config.userSettings.username;
        homeDirectory = lib.mkForce "/home/${config.userSettings.username}";
        # Specify additional outputs to install, such as documentation
        extraOutputsToInstall = ["doc" "devdoc"];

        # The initial version of Home Manager ration, should not be changed after set
        stateVersion = "24.05";
  };

}
