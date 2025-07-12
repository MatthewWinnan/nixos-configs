# https://rycee.gitlab.io/home-manager/options.xhtml
{
  inputs,
  config,
  lib,
  ...
}: {
  home-manager = {
    # Synchronize package sets between NixOS and Home Manager
    useGlobalPkgs = true;

    # enable the usage user packages through
    # the users.users.<name>.packages option
    useUserPackages = true;

    # Define a standard file extension for backup files created by Home Manager
    backupFileExtension = "hm.backup";

    extraSpecialArgs = {inherit inputs;};
    users = {
      # Import your home-manager configuration
      ${config.userSettings.username} = {
        imports = [
          ../../../home
          ../settings
        ] ++ lib.optionals (config.systemSettings.profile == "personal" || config.systemSettings.profile == "gaming") 
        [inputs.nixcord.homeModules.nixcord];

        home = {
          username = config.userSettings.username;
          homeDirectory = lib.mkForce "/home/${config.userSettings.username}";

          # Specify additional outputs to install, such as documentation
          extraOutputsToInstall = ["doc" "devdoc"];

          # The initial version of Home Manager ration, should not be changed after set
          stateVersion = "24.05";
        };

        # Configuration for the Home Manager manual and documentation
        manual = {
          # Disable installation of various manual formats to save space
          manpages.enable = false;
          html.enable = false;
          json.enable = false;
        };

        # Enable Home Manager to manage its own configurations
        programs.home-manager.enable = true;

        # Configure systemd to reload user services upon configuration changes
        systemd.user.startServices = "sd-switch"; # or "legacy" if "sd-switch" breaks again
      };
    };
  };
}
