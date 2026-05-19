{pkgs, ...}: {
  projectRootFile = "flake.nix";

  programs = {
    # Nix
    alejandra.enable = true;

    # Shell
    shfmt.enable = true;

    # TOML
    taplo.enable = true;

    # YAML
    yamlfmt.enable = true;

    # Markdown
    mdformat.enable = true;
  };

  settings.formatter = {
    shfmt.includes = ["*.sh" "*.bash"];
    yamlfmt.excludes = ["*.sops.*"];
  };
}
