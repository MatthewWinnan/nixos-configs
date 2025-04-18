#
# NuShell - a better alternative to zsh/bash with a lot of whistles
# NixOptions DOCS -> https://mynixos.com/home-manager/options/programs.nushell
#
{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.nushell = {
    enable = false;

    # Add conidtional aliases
    shellAliases = lib.mkMerge [
      # Alias to map yazi to lf for ease of use only if just yazi is enabled
      (lib.mkIf (config.programs.yazi.enable && !config.programs.lf.enable) {
        lf = "${lib.getExe pkgs.yazi}"; # This alias will be added only if yazi is enabled
      })

      # Alias to map bat to cat since muscle memory has me use cat...
      (
        lib.mkIf config.programs.bat.enable {
          cat = "${lib.getExe pkgs.bat}";
        }
      )

      # Alias for fuzzy finding and previewing files if fzf and bat is present
      (
        lib.mkIf (config.programs.fzf.enable && config.programs.bat.enable) {
          ff = ''find * -type f | ${lib.getExe pkgs.fzf} --preview "${lib.getExe pkgs.bat} --color=always --style=numbers --line-range=:500 {}" > selected'';
        }
      )

      # Default options
      {
        df = "${pkgs.duf}/bin/duf";
        find = "${pkgs.fd}/bin/fd";
        grep = "${pkgs.ripgrep}/bin/rg";
        tree = "${pkgs.eza}/bin/eza --git --icons --tree";
      }
    ];

    environmentVariables = {
      PROMPT_INDICATOR_VI_INSERT = ''"  "'';
      PROMPT_INDICATOR_VI_NORMAL = ''"∙ "'';
      PROMPT_COMMAND = ''""'';
      PROMPT_COMMAND_RIGHT = ''""'';
      DIRENV_LOG_FORMAT = ''""''; # make direnv quiet
      SHELL = ''"${pkgs.nushell}/bin/nu"'';
      EDITOR = ''"nvim"'';
    };

    # See the Nushell docs for more options.
    extraConfig = let
      conf = builtins.toJSON {
        show_banner = false;
        edit_mode = "vi";
        shell_integration = true;

        ls.clickable_links = true;
        rm.always_trash = true;

        table = {
          mode = "rounded";
          index_mode = "always";
          header_on_separator = false;
        };

        cursor_shape = {
          vi_insert = "line";
          vi_normal = "block";
        };

        menus = [
          {
            name = "completion_menu";
            only_buffer_difference = false;
            marker = "? ";
            type = {
              layout = "columnar"; # list, description
              columns = 4;
              col_padding = 2;
            };
            style = {
              text = "magenta";
              selected_text = "blue_reverse";
              description_text = "yellow";
            };
          }
        ];
      };
      completion = name: ''
        source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/${name}/${name}-completions.nu
      '';
      completions = names:
        builtins.foldl' (prev: str: ''
          ${prev}
          ${str}'') "" (map completion names);
    in ''
      $env.config = ${conf};
      ${completions ["git" "nix" "man" "cargo"]}

      def --env ff [...args] {
      	let tmp = (mktemp -t "yazi-cwd.XXXXX")
      	yazi ...$args --cwd-file $tmp
      	let cwd = (open $tmp)
      	if $cwd != "" and $cwd != $env.PWD {
      		cd $cwd
      	}
      	rm -fp $tmp
      }
    '';
  };
}
