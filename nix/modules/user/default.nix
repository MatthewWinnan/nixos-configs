{config, pkgs, ...}: {
programs.fish.enable = true;

  users = {
    defaultUserShell = pkgs.fish;

    users.${config.userSettings.username} = {
      isNormalUser = true;
      description = "${config.userSettings.name}";

      # We need to add dialout so I can serial and program MCU

      extraGroups = [ "networkmanager" "wheel" "input" "libvirtd" "dialout"];
      packages = with pkgs; [];
    };
  };

  # Enable automatic login for the user.
  # services.getty.autologinUser = "h3rm3s";
}
