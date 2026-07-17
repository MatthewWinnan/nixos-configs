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
        yaml = false;
      };

      links = {
        style = "wiki";
        implicit_extension = "md";
        transform_on_follow.__raw = ''
          function(path)
            -- Obsidian-style "shortest path" resolution:
            -- If path doesn't exist relative to root, search all subdirectories
            -- for a file matching the basename
            local root_markers = { ".obsidian", ".git" }
            local root = nil

            -- Walk up from current file to find root
            local current = vim.fn.expand("%:p:h")
            while current ~= "/" do
              for _, marker in ipairs(root_markers) do
                if vim.fn.isdirectory(current .. "/" .. marker) == 1
                   or vim.fn.filereadable(current .. "/" .. marker) == 1 then
                  root = current
                  break
                end
              end
              if root then break end
              current = vim.fn.fnamemodify(current, ":h")
            end

            if not root then return path end

            -- If the path already resolves, use it as-is
            local full = root .. "/" .. path
            if not path:match("%.md$") then
              full = full .. ".md"
            end
            if vim.fn.filereadable(full) == 1 then
              return path
            end

            -- Otherwise, search the vault for a matching filename
            local target = path
            if not target:match("%.md$") then
              target = target .. ".md"
            end
            -- Strip any directory prefix from the link text for basename matching
            local basename = vim.fn.fnamemodify(target, ":t")

            local found = vim.fn.globpath(root, "**/" .. basename, false, true)
            if #found > 0 then
              -- Return path relative to root
              local rel = found[1]:sub(#root + 2)
              -- Strip .md extension since implicit_extension adds it
              rel = rel:gsub("%.md$", "")
              return rel
            end

            return path
          end
        '';
      };

      # Resolve links relative to the notebook root
      path_resolution = {
        primary = "root";
        root_marker = ".obsidian";
        fallback = "current";
      };

      create_dirs = true;

      new_file_template = {
        use_template = false;
      };

      mappings = {
        # Follow link — same muscle memory as gd for code navigation
        MkdnEnter = {
          modes = ["n" "v"];
          key = "gd";
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
        MkdnCreateLinkFromClipboard = false;
      };
    };
  };
}
