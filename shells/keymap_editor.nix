# The following is a shell to build my own local version of
# https://github.com/nickcoutsos/keymap-editor
{pkgs}:
pkgs.mkShell rec {
  buildInputs = [
    pkgs.nodejs_20
    pkgs.react-static
  ];

  # We set some environment variables for building
  shellHook = ''
    export REACT_APP_ENABLE_LOCAL=y
  '';
}
