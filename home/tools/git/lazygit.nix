# Obtained from https://github.com/sukhmancs/nixos-configs/blob/94b744f0f81d4a610fccdab94e5b25a2138d4c92/homes/shared/programs/git/lazygit.nix
{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    lazygit
  ];

  programs.lazygit = {
    enable = true;
    settings = {
      notARepository = "quit";

      gui = {
        theme = {
          unstagedChangesColor = ["red" "bold"];
          selectedLineBgColor = ["#263c42"];
          selectedRangeBgColor = ["#263c42"];
        };
      };

      git = {
        paging = {
          colorArg = "always";
          pager = "delta --dark --paging=never";
        };
      };

      keybinding = {
        universal = {
          gotoTop = "g";
          gotoBottom = "G";
        };
        commits = {
          viewResetOptions = "m";
        };
        stash = {
          popStash = "o";
        };
      };
    };
  };
}
