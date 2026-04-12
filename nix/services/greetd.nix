{
  pkgs,
  config,
  ...
}: let
  isHeadless = config.deviceSettings.headless;
in {
  services.greetd = {
    enable = true;
    settings.default_session.command =
      if isHeadless
      then ''
        ${pkgs.tuigreet}/bin/tuigreet \
          --time \
          --asterisks \
          --user-menu \
          --cmd ${pkgs.fish}/bin/fish
      ''
      else ''
        ${pkgs.tuigreet}/bin/tuigreet \
          --remember \
          --time \
          --asterisks \
          --user-menu \
          --cmd "${pkgs.uwsm}/bin/uwsm start -e -D Hyprland hyprland.desktop"
      '';
  };

  environment.etc =
    if isHeadless
    then {}
    else {
      "greetd/environments".text = ''
        uwsm start -e -D Hyprland hyprland.desktop
      '';
    };
}
