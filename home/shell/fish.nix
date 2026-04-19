# NixOptions DOCS -> https://mynixos.com/home-manager/options/programs.fish
{
  config,
  lib,
  pkgs,
  ...
}:
let
  dig = lib.meta.getExe' pkgs.dnsutils "dig";
in
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      clear;sleep 0.1;fastfetch

      # Quick open with xdg-open
      function open
        xdg-open $argv >/dev/null 2>&1 &
        disown
      end

      # Edit file from fzf selection
      function eff
        set file (${lib.getExe pkgs.fzf} --preview '${lib.getExe pkgs.bat} --style=numbers --color=always {}')
        if test -n "$file"
          $EDITOR "$file"
        end
      end

      # Smart cd with zoxide - use z for fuzzy matching, cd for direct paths
      function zd
        if test (count $argv) -eq 0
          builtin cd ~
        else if test -d $argv[1]
          builtin cd $argv[1]
        else
          z $argv
        end
      end
    '';

    # Add conidtional aliases
    shellAliases = lib.mkMerge [
      # Alias to map yazi to lf for ease of use only if just yazi is enabled
      (lib.mkIf (config.programs.yazi.enable && !config.programs.lf.enable) {
        lf = "${lib.getExe config.programs.yazi.package}"; # This alias will be added only if yazi is enabled
      })

      # Alias to map bat to cat since muscle memory has me use cat...
      (lib.mkIf config.programs.bat.enable {
        cat = "${lib.getExe pkgs.bat}";
      })

      # Alias for fuzzy finding and previewing files if fzf and bat is present
      (lib.mkIf (config.programs.fzf.enable && config.programs.bat.enable) {
        ff = ''find * -type f | ${lib.getExe pkgs.fzf} --preview "${lib.getExe pkgs.bat} --color=always --style=numbers --line-range=:500 {}" > selected'';
      })

      # Default options
      # Just making everything cute
      {
        df = "${pkgs.duf}/bin/duf";
        du = "${pkgs.dust}/bin/dust";
        find = "${pkgs.fd}/bin/fd";
        grep = "${pkgs.ripgrep}/bin/rg";
        ps = "${pkgs.procs}/bin/procs";
        sed = "${pkgs.sd}/bin/sd";
        cut = "${pkgs.choose}/bin/choose";
        diff = "${pkgs.delta}/bin/delta";
        dig = "${pkgs.doggo}/bin/doggo";
        curl = "${pkgs.xh}/bin/xh";
        hexdump = "${pkgs.hexyl}/bin/hexyl";
        tree = "${pkgs.eza}/bin/eza --git --icons --tree";

        # File navigation with eza
        ls = "${pkgs.eza}/bin/eza -lh --group-directories-first --icons=auto";
        lsa = "${pkgs.eza}/bin/eza -lha --group-directories-first --icons=auto";
        lt = "${pkgs.eza}/bin/eza --tree --level=2 --long --icons --git";

        # Some x programs do no like running in wayland, we force to go through the xwayland translation layer
        set_x = "export WAYLAND_DISPLAY= ; export QT_QPA_PLATFORM=xcb";

        # faster navigation
        ".." = "cd ..";
        "..." = "cd ../../";
        "...." = "cd ../../../";
        "....." = "cd ../../../../";
        "......" = "cd ../../../../../";

        # Tool shortcuts
        d = "docker";
        g = "git";
        gcm = "git commit -m";
        gcam = "git commit -a -m";
        gcad = "git commit -a --amend";
        n = "nvim .";

        # insteaed of querying some weird and random"what is my ip" service
        # we get our public ip by querying opendns directly.
        # <https://unix.stackexchange.com/a/81699>
        my_ip = "${dig} @resolver4.opendns.com myip.opendns.com +short";
        my_ipv4 = "${dig} @resolver4.opendns.com myip.opendns.com +short -4";
        my_ipv6 = "${dig} @resolver1.ipv6-sandbox.opendns.com AAAA myip.opendns.com +short -6";
      }

      # Tmux shortcut
      (lib.mkIf config.programs.tmux.enable {
        t = "tmux attach || tmux new -s Work";
      })

      # Smart cd with zoxide
      (lib.mkIf config.programs.zoxide.enable {
        cd = "zd";
      })
    ];
  };
}
