# NixOptions DOCS -> https://mynixos.com/home-manager/options/programs.fish

{ config, lib, pkgs,... }:
let
  dig = lib.meta.getExe' pkgs.dnsutils "dig";
in
{
  programs.fish = {
    enable = true;
    interactiveShellInit = "clear;sleep 0.1;fastfetch";

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
        lib.mkIf (config.programs.fzf.enable && config.programs.bat.enable){
          ff = ''find * -type f | ${lib.getExe pkgs.fzf} --preview "${lib.getExe pkgs.bat} --color=always --style=numbers --line-range=:500 {}" > selected'';
        }
      )

      # Default options
      # Just making everything cute
      (
        {
        df = "${pkgs.duf}/bin/duf";
        find = "${pkgs.fd}/bin/fd";
        grep = "${pkgs.ripgrep}/bin/rg";
          tree = "${pkgs.eza}/bin/eza --git --icons --tree";

        # Some x programs do no like running in wayland, we force to go through the xwayland translation layer
        set_x = "export WAYLAND_DISPLAY= ; export QT_QPA_PLATFORM=xcb";

          # faster navigation
          ".." = "cd ..";
          "..." = "cd ../../";
          "...." = "cd ../../../";
          "....." = "cd ../../../../";
          "......" = "cd ../../../../../";

          # insteaed of querying some weird and random"what is my ip" service
          # we get our public ip by querying opendns directly.
          # <https://unix.stackexchange.com/a/81699>
          canihazip = "${dig} @resolver4.opendns.com myip.opendns.com +short";
          canihazip4 = "${dig} @resolver4.opendns.com myip.opendns.com +short -4";
          canihazip6 = "${dig} @resolver1.ipv6-sandbox.opendns.com AAAA myip.opendns.com +short -6";          
        }
      )

    ];

  };
}
