{
  config,
  pkgs,
  lib,
  ...
}: let
  shellPkg =
    {
      "fish" = pkgs.fish;
      "zsh" = pkgs.zsh;
      "bash" = pkgs.bash;
      "nushell" = pkgs.nushell;
    }.${
      config.userSettings.shell
    };
in {
  # Enable the selected shell at the system level (required for login shell to work)
  programs.fish.enable = config.userSettings.shell == "fish";
  programs.zsh.enable = config.userSettings.shell == "zsh";

  users = lib.mkMerge [
    (
      {
        # Authorised SSH keys, declared for every profile so key auth is
        # guaranteed by the build rather than by whatever is in ~/.ssh on a
        # given box. These are *public* keys: they are safe to commit and do
        # not belong in sops. Putting them behind sops would also make SSH
        # access depend on sops, which decrypts using /etc/ssh/ssh_host_*_key
        # - a circular dependency that bites exactly when you need to get in
        # to repair a host.
        users.${config.userSettings.username}.openssh.authorizedKeys.keys = [
          "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAHcQl2LRUDq87vJYyVZ+5JApMzeiLfQvF/T5Fs+HvsMWiXFkm+/Pe0tARdLhFNBnkXYDQW3o4xS6xaXr6KTaByDEwAgu+5ADkpQZ4M+T9DePPuyEY7m9u9A3lgcJvZtbvxrPiRYgV38asQMuSq0NVRlMPaLJfHKLm7Tj01LW+80ExHnfQ== mcwinnan@gmail.com"
        ];
      }
    )
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

  services.udev.packages =
    lib.mkIf
    (config.systemSettings.profile == "personal" || config.systemSettings.profile == "gaming")
    [pkgs.openocd];

  # Enable automatic login for the user.
  # services.getty.autologinUser = "h3rm3s";
}
