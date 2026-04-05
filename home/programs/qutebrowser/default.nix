# https://mynixos.com/home-manager/options/programs.qutebrowser
{pkgs, lib, ...}: let
  # Wrap qutebrowser to ensure it uses the correct curl with OpenSSL
  # Fixes: CURL_OPENSSL_4 not found (arduino-ide FHS env leaks wrong curl)
  qutebrowser-wrapped = pkgs.symlinkJoin {
    name = "qutebrowser-wrapped";
    paths = [pkgs.qutebrowser];
    buildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/qutebrowser \
        --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [pkgs.curl pkgs.libproxy]}"
    '';
  };
in {
  config.programs.qutebrowser = {
    enable = true;
    package = qutebrowser-wrapped;

    keyBindings = {
      normal = {
        "=" = "cmd-set-text -s :open";
      };
    };

    searchEngines = {
      w = "https://en.wikipedia.org/wiki/Special:Search?search={}&amp;go=Go&amp;ns0=1";
      aw = "https://wiki.archlinux.org/?search={}";
      cio = "https://crates.io/search?q={}";
      nw = "https://wiki.nixos.org/index.php?search={}";
      nh = "https://home-manager-options.extranix.com/?query={}";
      no = "https://mynixos.com/search?q={}";
      nv = "https://nix-community.github.io/nixvim/?search={}";
      g = "https://www.google.com/search?q={}";
      gh = "https://www.github.com/search?q={}&type=repositories";
      d = "https://duckduckgo.com/?q={}";
      pd = "https://protondb.com/search?q={}";
      bg = "https://boardgamegeek.com/geeksearch.php?action=search&objecttype=boardgame&q={}";
    };

    greasemonkey = [
      (pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/afreakk/greasemonkeyscripts/1d1be041a65c251692ee082eda64d2637edf6444/youtube_sponsorblock.js";
        sha256 = "sha256-e3QgDPa3AOpPyzwvVjPQyEsSUC9goisjBUDMxLwg8ZE=";
      })
      (pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/afreakk/greasemonkeyscripts/1d1be041a65c251692ee082eda64d2637edf6444/youtube_adblock.js";
        sha256 = "sha256-EuGTJ9Am5C6g3MeTsjBQqyNFBiGAIWh+f6cUtEHu3iI=";
      })
    ];

    settings = {
      editor = {
        command = ["${pkgs.kitty}/bin/kitty" "${pkgs.neovim}/bin/nvim" "{file}" "-c" "normal {line}G{column0}l"];
      };
      window = {
        transparent = true;
      };
      colors = {
        webpage = {
          darkmode = {
            enabled = true;
            algorithm = "lightness-cielab";
            policy = {
              images = "never";
            };
          };
        };
      };
    };
  };
}
