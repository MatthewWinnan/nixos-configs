# This is done so I can at least do some edits in nvim for my Arduino projects.
# This will setup the needed tools to get arduino-lsp up and running
# DOCS arduino-lsp -> https://nix-community.github.io/nixvim/plugins/lsp/servers/arduino_language_server/index.html

{ pkgs, ... }:

pkgs.mkShell rec {
  buildInputs = [
    pkgs.arduino-cli
    pkgs.llvmPackages_19.clang-tools
    (pkgs.buildGoModule rec {
      pname = "arduino-language-server";
      version = "latest";
      src = pkgs.fetchFromGitHub {
        owner = "speelbarrow";
        repo = "arduino-language-server";
        rev = "HEAD"; # Use "HEAD" for the latest commit or pin to a specific commit for reproducibility
        hash = "sha256-UlNJsdhkFNgQQeQjHfJlIzX9viX/cZ82omg2wy2SQSM="; # Replace with the actual hash
      };
      vendorHash = "sha256-Mu9W92f8ZEaTfJ8YkhKpOvFMB/QzqoxfWkSGWlU/yVM="; # Replace with the actual vendor hash
    })
  ];
}
