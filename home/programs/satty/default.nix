# https://github.com/Satty-org/Satty
{
  pkgs,
  config,
  ...
}: {
  programs.satty = {
    enable = true;

    settings = {
      general = {
        # Start in fullscreen mode
        fullscreen = true;

        # Default output location (uses XDG pictures directory)
        output-filename = "${config.xdg.userDirs.pictures}/screenshot-%Y-%m-%d_%H:%M:%S.png";

        # Exit after first save/copy action
        early-exit = true;

        # Copy to clipboard using wl-copy
        copy-command = "wl-copy";

        # Start with arrow tool (good for annotations)
        initial-tool = "arrow";

        # Save after copying to clipboard
        save-after-copy = true;
      };

      font = {
        family = "monospace";
      };
    };
  };
}
