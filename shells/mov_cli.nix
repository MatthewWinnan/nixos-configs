# This is ideally just to test if how I package things works.
{pkgs}: let
  callPackage = pkgs.callPackage;
  pythonPackages = pkgs.python312Packages;
  pyPkgs = pythonPackages:
    with pythonPackages; [
      pip
      venvShellHook
      ipython
      setuptools
    ];
in
  pkgs.mkShell rec {
    buildInputs = [
      pkgs.python312
      (pkgs.python312.withPackages pyPkgs)
      (callPackage ../derivations/mov-cli/mov-cli {})
      (callPackage ../derivations/mov-cli/plugins/youtube {})
      (callPackage ../derivations/mov-cli/plugins/otaku {})
    ];

    shellHook = ''
      echo "mov-cli environment 🎥"
    '';
  }
