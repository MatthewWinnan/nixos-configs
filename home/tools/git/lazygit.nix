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
        # GitLab: View MR in browser for selected branch
        {
          key = "V";
          context = "localBranches";
          command = "glab mr view --web {{.SelectedLocalBranch.Name}}";
          output = "log";
          description = "View MR in browser";
        }
        # GitLab: Quick pipeline status (global)
        {
          key = "I";
          context = "global";
          command = "glab ci view";
          output = "terminal";
          description = "GitLab CI pipeline view";
        }
        # GitLab: List open MRs (from branches context - see what's in review)
        {
          key = "L";
          context = "localBranches";
          command = "glab mr list";
          output = "terminal";
          description = "List my open MRs";
        }
        # GitLab: Create MR from selected branch
        {
          key = "C";
          context = "localBranches";
          command = "glab mr create --web --source-branch {{.SelectedLocalBranch.Name}}";
          output = "log";
          description = "Create MR in browser";
        }
        # GitLab: Interactive pipeline viewer for selected branch
        {
          key = "E";
          context = "localBranches";
          command = "glab ci view {{.SelectedLocalBranch.Name}}";
          output = "terminal";
          description = "View branch pipeline (interactive)";
        }
        # GitLab: View pipeline from commits context
        {
          key = "H";
          context = "commits";
          command = "glab ci view";
          output = "terminal";
          description = "View pipeline (interactive)";
        }
        # Tig: blame current file at selected commit
        {
          key = "X";
          context = "commits";
          command = "tig blame {{.SelectedLocalCommit.Sha}} -- {{.SelectedCommitFile.Name}}";
          output = "terminal";
          description = "Blame file at commit (tig)";
        }
        # Tig: browse repo at selected commit
        {
          key = "W";
          context = "commits";
          command = "tig show {{.SelectedLocalCommit.Sha}}";
          output = "terminal";
          description = "Browse commit (tig)";
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
