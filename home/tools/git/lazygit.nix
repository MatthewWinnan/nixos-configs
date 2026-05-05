# Obtained from https://github.com/sukhmancs/nixos-configs/blob/94b744f0f81d4a610fccdab94e5b25a2138d4c92/homes/shared/programs/git/lazygit.nix
{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (config.lib.stylix) colors;
in {
  home.packages = with pkgs; [
    lazygit
    serie
  ];

  programs.lazygit = {
    enable = true;
    settings = {
      notARepository = "quit";

      gui = {
        sidePanelWidth = 0.2;
        theme = {
          activeBorderColor = ["#${colors.base0D}" "bold"];
          inactiveBorderColor = ["#${colors.base03}"];
          searchingActiveBorderColor = ["#${colors.base0A}" "bold"];
          optionsTextColor = ["#${colors.base0D}"];
          selectedLineBgColor = ["#${colors.base02}"];
          selectedRangeBgColor = ["#${colors.base02}"];
          cherryPickedCommitBgColor = ["#${colors.base0B}"];
          cherryPickedCommitFgColor = ["#${colors.base00}"];
          unstagedChangesColor = ["#${colors.base08}" "bold"];
          defaultFgColor = ["#${colors.base05}"];
        };
      };

      git = {
        pagers = [
          {
            colorArg = "always";
            pager = "delta --dark --paging=never --side-by-side --line-numbers --hyperlinks --hyperlinks-file-link-format=\"lazygit-edit://{path}:{line}\" --syntax-theme=base16-256";
          }
          {
            externalDiffCommand = "difft --color=always";
          }
        ];
      };

      customCommands = [
        {
          key = "S";
          context = "global";
          command = "serie";
          output = "terminal";
          description = "Open serie git graph";
        }
        {
          key = "V";
          context = "localBranches";
          command = "glab mr view --web";
          output = "terminal";
          description = "View MR in browser";
        }
        {
          key = "I";
          context = "global";
          command = "glab ci status";
          output = "terminal";
          description = "GitLab CI pipeline status";
        }
      ];

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
