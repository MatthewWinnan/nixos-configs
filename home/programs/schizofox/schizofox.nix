{
  self',
  inputs,
  osConfig,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config.lib.stylix) colors;
in {
  imports = [
    inputs.schizofox.homeManagerModule
  ];
  # config = mkIf config.programs.firefox.enable
  config = {
    programs.schizofox = {
      enable = true;
      theme = {
        font = "Inter";
        colors = {
          background-darker = "${colors.base01}";
          background = "${colors.base00}";
          foreground = "${colors.base05}";
          primary = "${colors.base0E}";
        };
      };

      settings = {
        "security.OCSP.enabled" = 1;
        "services.sync.engine.prefs" = false;
        "services.sync.engine.addons" = false;
        # Suppose to fix https://bugzilla.mozilla.org/show_bug.cgi?id=1639575
        "widget.use-xdg-desktop-portal" = false;
      };

      search = rec {
        defaultSearchEngine = "Searxng";
        removeEngines = ["Bing" "Amazon.com" "eBay" "Twitter" "Wikipedia" "LibRedirect" "DuckDuckGo"];

        # This was used by sukhmancs, can't use anymore
        # searxUrl = "https://search.xilain.dev";
        # searxQuery = "${searxUrl}/search?q={searchTerms}&categories=general";

        # Conditionally set searxUrl and searxQuery based on the profile
        searxUrl = if config.systemSettings.profile == "work"
             then "http://taskit-searchxng/searxng"
             else "https://searxng.site";

        searxQuery = "${searxUrl}/search?q={searchTerms}&categories=general";
        addEngines = [
          {
            Name = "Searxng";
            Description = "Decentralized search engine";
            Alias = "sx";
            Method = "GET";
            URLTemplate = "${searxQuery}";
          }
          {
            Name = "Etherscan";
            Description = "Checking balances";
            Alias = "!eth";
            Method = "GET";
            URLTemplate = "https://etherscan.io/search?f=0&q={searchTerms}";
          }
        ];
      };

      security = {
        sanitizeOnShutdown = false;
        sandbox = true;
        noSessionRestore = false;
        userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/106.0";
      };

      misc = {
        drm.enable = true;
        disableWebgl = false;
        firefoxSync = true;
      };

      # Schizofox also have default extensions: temporary-containers, localcdn-fork-of-decentraleyes, don-t-fuck-with-paste, clearurls, libredirect, etc
      extensions = {
        simplefox.enable = true;
        darkreader.enable = true;
        enableExtraExtensions = true;
        extraExtensions = {
          "cb-remover@search.mozilla.org".install_url = "https://addons.mozilla.org/firefox/downloads/latest/clickbait-remover-for-youtube/latest.xpi";
          "treestyletab@piro.sakura.ne.jp".install_url = "https://addons.mozilla.org/firefox/downloads/latest/tree-style-tab/latest.xpi";
          "sponsorBlocker@ajay.app".install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          "2.0@disconnect.me".install_url = "https://addons.mozilla.org/firefox/downloads/latest/disconnect/latest.xpi";
          # "extension@one-tab.com".install_url = "https://addons.mozilla.org/firefox/downloads/latest/onetab/latest.xpi";
          "browser-extension@anonaddy".install_url = "https://addons.mozilla.org/firefox/downloads/latest/addy_io/latest.xpi";
          #  "vimium-c@gdh1995.cn".install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-c/latest.xpi";
          "{1018e4d6-728f-4b20-ad56-37578a4de76b}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/flagfox/latest.xpi";
          "{c2c003ee-bd69-42a2-b0e9-6f34222cb046}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/auto-tab-discard/latest.xpi";
          "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/refined-github-/latest.xpi";
          "{d7742d87-e61d-4b78-b8a1-b469842139fa}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
          "{0d7cafdd-501c-49ca-8ebb-e3341caaa55e}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/youtube-nonstop/latest.xpi";
          # "{446900e4-71c2-419f-a6a7-df9c091e268b}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          "{5ca032f5-aaac-41f6-85eb-99ec4bfcf828}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/pesticide/latest.xpi";
        };
      };

      # Periodically add to book marks
       misc.bookmarks = [
        {
      Title = "Cloud-04";
      URL = "https://172.16.2.125:8006/";
      Placement = "toolbar";
      Folder = "WorkTools";
        }
        {
          Title = "Godbolt";
          URL = "https://godbolt.org/";
          Folder = "WorkTools";
        }
        {
          Title = "NVIMDEV (lspsaga doc)";
          URL = "https://nvimdev.github.io/lspsaga/";
          Folder = "nvim";
        }
        {
        Title = "None-LS";
        URL = "";
        Folder = "nvim";
        }
        {
        Title = "Trouble-LS";
        URL = "https://github.com/folke/trouble.nvim";
        Folder = "nvim";
        }
        {
          Title = "NixOptions";
          URL = "https://mynixos.com/";
          Folder = "utils";
        }
        {
          Title = "NixVim";
          URL = "https://nix-community.github.io/nixvim/user-guide/install.html";
          Folder = "nvim";
        }
        {
          Title = "CapibaraZero";
          URL = "https://capibarazero.github.io/docs/";
          Folder = "personal";
        }
        {
        Title = "Ngram Type";
        URL = "https://ranelpadon.github.io/ngram-type/";
        Folder = "Typing Lessons";
        }
        {
        Title = "Monkey Type";
        URL = "https://monkeytype.com/";
        Folder = "Typing Lessons";
        }
        {
        Title = "KEYBR";
        URL = "https://www.keybr.com/";
        Folder = "Typing Lessons";
        }
        {
        Title = "Typing Club";
        URL = "https://www.edclub.com/sportal/";
        Folder = "Typing Lessons";
        }
        {
          Title = "Keyboard Layout Editor";
          URL = "https://nickcoutsos.github.io/keymap-editor/";
          Folder = "Ergo Keyboards";
        }
        {
          Title = "Alternate Layout Tester";
          URL = "https://keyboard-layout-try-out.pages.dev/";
          Folder = "Typing Lessons";
        }
      ];
    };
  };
}
