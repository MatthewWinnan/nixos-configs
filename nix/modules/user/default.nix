{config, pkgs, lib, ...}: {
programs.fish.enable = true;

  users = lib.mkMerge [
      (lib.mkIf (config.systemSettings.profile == "work"){
      defaultUserShell = pkgs.fish;

      users.${config.userSettings.username} = {
           isNormalUser = true;
          description = "${config.userSettings.name}";

            extraGroups = [ "networkmanager" "wheel" "input" "libvirtd" "wireshark"];
            packages = with pkgs; [];
      };

      groups = {
        wireshark = {};
      };

        }
      )
      (lib.mkIf (config.systemSettings.profile == "personal" || config.systemSettings.profile == "gaming"){
        defaultUserShell = pkgs.fish;
        users.${config.userSettings.username} = {
           isNormalUser = true;
          description = "${config.userSettings.name}";

          # We need to add dialout so I can serial and program MCU

          extraGroups = [ "networkmanager" "wheel" "input" "libvirtd" "dialout"];
          packages = with pkgs; [];
          };
        }
      )
    ];
  # Enable automatic login for the user.
  # services.getty.autologinUser = "h3rm3s";
}
