#
# ripgrep - Recursively search directories for a regex pattern
#
# Usage: rg regular_expression [path ...]
#
{config, ...}: let
  inherit (config.lib.stylix) colors;
  # Convert a 6-char hex color to ripgrep's "0xRR,0xGG,0xBB" format
  hexToRg = hex: "0x${builtins.substring 0 2 hex},0x${builtins.substring 2 2 hex},0x${builtins.substring 4 2 hex}";
in {
  programs.ripgrep = {
    enable = true;
    arguments = [
      # Don't let ripgrep vomit really long lines to my terminal, and show a preview.
      "--max-columns=150"
      "--max-columns-preview"

      # Search hidden files or directories by default
      "--hidden"

      # ignore git files
      "--glob=!.git/*"

      # case insensitive search
      "--smart-case"

      # Stylix-aware colors
      "--colors=match:fg:${hexToRg colors.base0A}"
      "--colors=match:style:bold"
      "--colors=path:fg:${hexToRg colors.base0D}"
      "--colors=path:style:bold"
      "--colors=line:fg:${hexToRg colors.base0E}"
      "--colors=line:style:bold"
      "--colors=column:fg:${hexToRg colors.base04}"
    ];
  };
}
