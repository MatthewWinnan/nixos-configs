{
  config,
  pkgs,
  lib,
  ...
}:
let
  shellPkg = {
    "fish" = pkgs.fish;
    "zsh" = pkgs.zsh;
    "bash" = pkgs.bash;
    "nushell" = pkgs.nushell;
  }.${config.userSettings.shell};
in
{
  # Enable the selected shell at the system level (required for login shell to work)
  programs.fish.enable = config.userSettings.shell == "fish";
  programs.zsh.enable = config.userSettings.shell == "zsh";

  users = lib.mkMerge [
    (
      lib.mkIf (config.systemSettings.profile == "work") {
        defaultUserShell = shellPkg;

        users.${config.userSettings.username} = {
          isNormalUser = true;
          description = "${config.userSettings.name}";

          extraGroups = ["networkmanager" "wheel" "input" "libvirtd" "wireshark" "docker" "podman"];
          packages = with pkgs; [];
        };

        groups = {
          wireshark = {};
        };
      }
    )
    (
      lib.mkIf (config.systemSettings.profile == "personal" || config.systemSettings.profile == "gaming") {
        defaultUserShell = shellPkg;
        users.${config.userSettings.username} = {
          isNormalUser = true;
          description = "${config.userSettings.name}";

          # We need to add dialout so I can serial and program MCU

          extraGroups = ["networkmanager" "wheel" "input" "libvirtd" "dialout" "mpd"];
          packages = with pkgs; [];
        };
      }
    )
  ];
  # Enable automatic login for the user.
  # services.getty.autologinUser = "h3rm3s";
}
