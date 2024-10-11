{ config, lib, pkgs,... }: {
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
    ];

  };
}
