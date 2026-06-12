# DOCS -> https://github.com/harrisoncramer/gitlab.nvim
{
  pkgs,
  config,
  lib,
  ...
}: let
  enabled = config.systemSettings.profile == "work";

  gitlab-server = pkgs.buildGoModule {
    pname = "gitlab-nvim-server";
    version = "unstable-2025-06-01";
    src = pkgs.fetchFromGitHub {
      owner = "harrisoncramer";
      repo = "gitlab.nvim";
      rev = "f01ccbdaef7e8460af72c75be65f5f359928a0b4";
      hash = "sha256-qLiXbeN4+14eJrfespCNc+p3qr1KCKurysbPuTsB4J8=";
    };
    vendorHash = "sha256-OLAKTdzqynBDHqWV5RzIpfc3xZDm6uYyLD4rxbh0DMg=";
    subPackages = ["cmd"];
    postInstall = ''
      mv $out/bin/cmd $out/bin/gitlab-nvim-server
      cp -r cmd/config $out/bin/config
    '';
  };

  gitlab-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "gitlab-nvim";
    version = "unstable-2025-06-01";
    src = pkgs.fetchFromGitHub {
      owner = "harrisoncramer";
      repo = "gitlab.nvim";
      rev = "f01ccbdaef7e8460af72c75be65f5f359928a0b4";
      hash = "sha256-qLiXbeN4+14eJrfespCNc+p3qr1KCKurysbPuTsB4J8=";
    };
    doCheck = false;
    postPatch = ''
      sed -i '/local function setup/,/state.merge_settings/ {
        /local version_issue/,/^$/d
      }' lua/gitlab/init.lua
    '';
  };
in {
  programs.nixvim = {
    extraPlugins = lib.mkIf enabled [
      gitlab-nvim
      pkgs.vimPlugins.nui-nvim
    ];

    extraConfigLua = lib.mkIf enabled ''
      require("gitlab").setup({
        debug = { go_request = false, go_response = false },
        config_path = vim.fn.expand("~"),
        connection_settings = {
          insecure = true,
        },
        reviewer_settings = {
          diffview = {
            imply_local = false,
          },
        },
        server = {
          binary = "${gitlab-server}/bin/gitlab-nvim-server",
          binary_provided = true,
        },
      })
    '';

    keymaps = lib.mkIf enabled [
      {
        mode = "n";
        key = "<leader>gR";
        action = "<cmd>lua require('gitlab').review()<cr>";
        options.desc = "GitLab: Start review";
      }
      {
        mode = "n";
        key = "<leader>gS";
        action = "<cmd>lua require('gitlab').summary()<cr>";
        options.desc = "GitLab: MR summary";
      }
      {
        mode = "n";
        key = "<leader>gA";
        action = "<cmd>lua require('gitlab').approve()<cr>";
        options.desc = "GitLab: Approve MR";
      }
      {
        mode = "n";
        key = "<leader>gM";
        action = "<cmd>lua require('gitlab').merge()<cr>";
        options.desc = "GitLab: Merge MR";
      }
      {
        mode = "n";
        key = "<leader>gc";
        action = "<cmd>lua require('gitlab').create_comment()<cr>";
        options.desc = "GitLab: Create comment";
      }
      {
        mode = "v";
        key = "<leader>gc";
        action = "<cmd>lua require('gitlab').create_multiline_comment()<cr>";
        options.desc = "GitLab: Create multiline comment";
      }
      {
        mode = "n";
        key = "<leader>gn";
        action = "<cmd>lua require('gitlab').create_note()<cr>";
        options.desc = "GitLab: Create note";
      }
      {
        mode = "n";
        key = "<leader>gD";
        action = "<cmd>lua require('gitlab').toggle_discussions()<cr>";
        options.desc = "GitLab: Toggle discussions";
      }
      {
        mode = "n";
        key = "<leader>gp";
        action = "<cmd>lua require('gitlab').pipeline()<cr>";
        options.desc = "GitLab: Pipeline status";
      }
      {
        mode = "n";
        key = "<leader>gC";
        action = "<cmd>lua require('gitlab').choose_merge_request()<cr>";
        options.desc = "GitLab: Choose MR";
      }
    ];
  };
}
