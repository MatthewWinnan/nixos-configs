{
  pkgs,
  config,
  lib,
  ...
}: let
  # Fetch the icons file using fetchurl
  iconsFile = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/gokcehan/lf/master/etc/icons.example";
    sha256 = "sha256-c0orDQO4hedh+xaNrovC0geh5iq2K+e+PZIL5abxnIk=";
  };

  previewer = pkgs.writeShellScriptBin "pv.sh" ''
    file=$1
    w=$2
    h=$3
    x=$4
    y=$5
    mime_type=$( ${pkgs.file}/bin/file -Lb --mime-type "$file" )

    # If the file is an image, use Kitty to display it
    if [[ "$mime_type" =~ ^image ]]; then
        ${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
        exit 1
    fi

    # If none of the above, fall back to Pistol
    ${pkgs.pistol}/bin/pistol "$file"
  '';

  cleaner = pkgs.writeShellScriptBin "clean.sh" ''
    ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
  '';
in {
  xdg.configFile."lf/icons".source = iconsFile;

  programs.lf = {
    enable = false;
    commands = {
      dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"'';
      editor-open = ''$$EDITOR $f'';
      zathura-open = ''${pkgs.zathura}/bin/zathura $f'';
      mkdir = ''
        ''${{
          printf "Directory Name: "
          read DIR
          mkdir $DIR
        }}
      '';
    };

    keybindings = {
      "\\\"" = "";
      o = "";
      c = "mkdir";
      "." = "set hidden!";
      "`" = "mark-load";
      "\\'" = "mark-load";
      "<enter>" = "open";
      D = "dragon-out";
      P = "zathura-open";
      "g~" = "cd";
      gh = "cd";
      "g/" = "/";
      ee = "editor-open";
      V = ''$${pkgs.bat}/bin/bat --paging=always --theme=gruvbox "$f"'';
    };

    settings = {
      preview = true;
      hidden = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
    };

    extraConfig = ''
      set cleaner ${cleaner}/bin/clean.sh
      set previewer ${previewer}/bin/pv.sh
    '';
  };
}
