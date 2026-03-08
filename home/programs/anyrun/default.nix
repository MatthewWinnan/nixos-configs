# NixOptions -> https://mynixos.com/home-manager/options/programs.anyrun
{
  pkgs,
  inputs,
  ...
}: {
  # NB CSS seems to be broken in newer versions
  config.programs.anyrun = {
    enable = true;
    config = {
      y.fraction = 0.2;
      closeOnClick = true;
      hidePluginInfo = true;
      showResultsImmediately = true;
      maxEntries = 10;
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
        dictionary
        rink
        translate
      ];
    };

    extraCss = ''
        window {
        background: transparent;
      }

      .main {
        background: rgba(36, 39, 58, 0.7);
        border-radius: 16px;
        padding: 8px;
        box-shadow: 0px 2px 33px -5px rgba(0, 0, 0, 0.5);
      }

      .matches {
        background: transparent;
      }

      .plugin {
        background: transparent;
        box-shadow: none;
      }

      GtkText {
        color: white;
        box-shadow: none;
        border-radius: 12px;
        border: 2px solid #b7bdf8;
        background: transparent;
      }

      .match {
        background: transparent;
        box-shadow: none;
        padding: 12px 14px;
        border-radius: 12px;
        color: white;
        margin-top: 4px;
        border: 2px solid transparent;
        transition: all 0.3s ease;
      }

      .match:not(:first-child) {
        border-top-left-radius: 0;
        border-top-right-radius: 0;
        border-top: 2px solid rgba(255, 255, 255, 0.1);
      }

      .match .title {
        font-size: 1.3rem;
        color: inherit;
      }

      .match .description {
        color: inherit;
      }

      .match:hover {
        border: 2px solid rgba(255, 255, 255, 0.4);
        border-top-left-radius: 12px;
        border-top-right-radius: 12px;
      }

      .match:selected {
        background: rgba(255, 255, 255, 0.1);
        border: 2px solid #c6a0f6;
        border-top-left-radius: 12px;
        border-top-right-radius: 12px;
      }

      .match:hover + .match,
      .match:selected + .match {
        border-top: 2px solid transparent;
      }    '';
  };
}
