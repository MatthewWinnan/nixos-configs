# DOCS -> https://github.com/jakewvincent/mkdnflow.nvim
# https://nix-community.github.io/nixvim/plugins/mkdnflow/index.html
# Provides [[wiki link]] navigation, link creation, and notebook management
# Compatible with Obsidian-style vaults (e.g., ~/DEV/notes/)
{
  programs.nixvim.plugins.mkdnflow = {
    enable = true;
    settings = {
      modules = {
        bib = true;
        buffers = true;
        conceal = true;
        cursor = true;
        folds = true;
        foldtext = true;
        links = true;
        lists = true;
        maps = true;
        paths = true;
        tables = true;
        yaml = false; # We handle YAML frontmatter separately
      };

      links = {
        style = "wiki"; # [[wiki links]] — matches Obsidian
        implicit_extension = ".md";
        transform_implicit = false;
        transform_explicit.__raw = ''
          function(text)
            -- Keep link text as-is (Obsidian compatibility)
            return text
          end
        '';
      };

      # Allow navigating to files in subdirectories from any depth
      perspective = {
        priority = "root"; # Resolve links relative to notebook root
        root_tell = ".obsidian"; # Detect vault root via .obsidian dir
        fallback = "current"; # Fallback to current file's directory
      };

      # Don't create new files when following a broken link (ask first)
      create_dirs = true;
      new_file_template = {
        use_template = false;
      };

      mappings = {
        # gf-style follow link / create link from word under cursor
        MkdnEnter = {
          modes = ["n" "v"];
          key = "<CR>";
        };
        # Go back after following a link
        MkdnGoBack = {
          modes = ["n"];
          key = "<BS>";
        };
        # Navigate between links in the buffer
        MkdnNextLink = {
          modes = ["n"];
          key = "<Tab>";
        };
        MkdnPrevLink = {
          modes = ["n"];
          key = "<S-Tab>";
        };
        # Table navigation
        MkdnTableNextCell = {
          modes = ["i"];
          key = "<Tab>";
        };
        MkdnTablePrevCell = {
          modes = ["i"];
          key = "<S-Tab>";
        };
        MkdnTableNextRow = false;
        MkdnTablePrevRow = {
          modes = ["i"];
          key = "<M-CR>";
        };
        MkdnTableNewRowBelow = {
          modes = ["n"];
          key = "<leader>ir";
        };
        MkdnTableNewRowAbove = {
          modes = ["n"];
          key = "<leader>iR";
        };
        MkdnTableNewColAfter = {
          modes = ["n"];
          key = "<leader>ic";
        };
        MkdnTableNewColBefore = {
          modes = ["n"];
          key = "<leader>iC";
        };
        # Checkbox toggling
        MkdnToggleToDo = {
          modes = ["n" "v"];
          key = "<C-Space>";
        };
        # Fold heading sections
        MkdnFoldSection = {
          modes = ["n"];
          key = "<leader>mf";
        };
        MkdnUnfoldSection = {
          modes = ["n"];
          key = "<leader>mF";
        };
        # Link creation (visual mode — select text then create link)
        MkdnCreateLinkFromClipboard = {
          modes = ["v"];
          key = "<leader>ml";
        };
        # Disable mappings we don't want
        MkdnDestroyLink = false;
        MkdnMoveSource = false;
        MkdnYankAnchorLink = false;
        MkdnYankFileAnchorLink = false;
        MkdnIncreaseHeading = false;
        MkdnDecreaseHeading = false;
        MkdnUpdateNumbering = false;
        MkdnSTab = false;
        MkdnTab = false;
        MkdnExtendList = false;
        MkdnNewListItemBelowInsert = false;
        MkdnNewListItemAboveInsert = false;
        MkdnCreateLink = false;
      };
    };
  };
}
