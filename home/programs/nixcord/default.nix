# https://kaylorben.github.io/nixcord/#getting-started
# https://github.com/KaylorBen/nixcord
{inputs, config, ...}: {
  config.programs.nixcord = {
    enable = config.systemSettings.profile == "personal" || config.systemSettings.profile == "gaming";
    discord = {
      enable = true;
      openASAR.enable = true;
      vencord.enable = true;
    };
    vesktop.enable = true;
    # https://github.com/KaylorBen/nixcord/blob/main/modules/hm-module.nix
    config = {
      # https://github.com/KaylorBen/nixcord/blob/main/modules/plugins.nix
      frameless = true;
      transparent = true;
      themeLinks = [
        "https://raw.githubusercontent.com/ClearVision/ClearVision-v7/master/ClearVision-v7.theme.css"
      ];
      enabledThemes = [
      ];
      plugins = {
        crashHandler = {
          enable = true;
        };
        fakeNitro = {
          enable = true;
          enableEmojiBypass = true;
        };
      };
    };
  };
}
