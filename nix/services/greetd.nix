{
  pkgs,
  config,
  lib,
  ...
}: let
  isHeadless = config.deviceSettings.headless;
  greeter = config.deviceSettings.greeter;
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
      else if greeter == "tuigreet"
      then ''
        ${pkgs.tuigreet}/bin/tuigreet \
          --remember \
          --time \
          --asterisks \
          --user-menu \
          --cmd "${pkgs.uwsm}/bin/uwsm start hyprland-uwsm.desktop"
      ''
      # regreet overrides this in regreet.nix via mkForce
      else "";
  };

  environment.etc =
    if isHeadless
    then {}
    else {
      "greetd/environments".text = ''
        uwsm start hyprland-uwsm.desktop
      '';
    };
}
