{ pkgs, ... }: {
  programs.fish.enable = true;

  users = {
    defaultUserShell = pkgs.fish;

    users.h3rm3s = {
      isNormalUser = true;
      description = "Matthew";
      
      # We need to add dialout so I can serial and program MCU

      extraGroups = [ "networkmanager" "wheel" "input" "libvirtd" "dialout"];
      packages = with pkgs; [];
    };
  };

  # Enable automatic login for the user.
  # services.getty.autologinUser = "h3rm3s";
}
