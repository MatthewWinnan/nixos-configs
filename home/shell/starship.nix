#
# Starship Prompt - Omarchy-inspired minimal config
#
# Clean, minimal prompt showing directory, git info, and status
# Integrates with Stylix colors
#
{
  config,
  ...
}: let
  inherit (config.lib.stylix) colors;
in {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      command_timeout = 200;
      format = "[$directory$git_branch$git_status]($style)$nix_shell$character";

      character = {
        error_symbol = "[✗](bold #${colors.base08})";
        success_symbol = "[❯](bold #${colors.base0D})";
        vimcmd_symbol = "[❮](bold #${colors.base0B})";
      };

      directory = {
        truncation_length = 2;
        truncation_symbol = "…/";
        style = "#${colors.base05}";
        repo_root_style = "bold #${colors.base0D}";
        repo_root_format = "[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) ";
      };

      git_branch = {
        format = "[$branch]($style) ";
        style = "italic #${colors.base0E}";
      };

      git_status = {
        format = "[$all_status]($style)";
        style = "#${colors.base0B}";
        ahead = "⇡\${count} ";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count} ";
        behind = "⇣\${count} ";
        conflicted = " ";
        up_to_date = "";
        untracked = "? ";
        modified = "● ";
        stashed = "";
        staged = "+ ";
        renamed = "» ";
        deleted = "✘ ";
      };

      nix_shell = {
        format = "[$symbol$state]($style) ";
        symbol = "󱄅 ";
        style = "#${colors.base0C}";
      };

      # Disable modules we don't need for minimal prompt
      aws.disabled = true;
      gcloud.disabled = true;
      kubernetes.disabled = true;
      azure.disabled = true;
      package.disabled = true;
      nodejs.disabled = true;
      python.disabled = true;
      rust.disabled = true;
      golang.disabled = true;
      java.disabled = true;
      ruby.disabled = true;
      lua.disabled = true;
      docker_context.disabled = true;
      terraform.disabled = true;
      cmd_duration.disabled = true;
      time.disabled = true;
      username.disabled = true;
      hostname.disabled = true;
      battery.disabled = true;
    };
  };
}
