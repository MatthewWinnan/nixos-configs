{pkgs}: let
  python = pkgs.python312;
  pythonPackages = pkgs.python312Packages;

  callPackage = pkgs.callPackage;

  config = ./config/config.toml;

  mov-cli = callPackage ./mov-cli {};
  mov-cli-youtube = callPackage ./plugins/youtube {};
  otaku-watcher = callPackage ./plugins/otaku {};

  pyPkgs = pythonPackages:
    with pythonPackages; [
      lxml
    ];

  pythonEnv = python.withPackages (ps: [
    mov-cli
    mov-cli-youtube
    otaku-watcher
    (pkgs.python312.withPackages pyPkgs)
  ]);
in
  pkgs.stdenv.mkDerivation {
    pname = "mov-cli-wrapper";
    version = "1.0";

    # Apparently this is safer
    # https://github.com/NixOS/nixpkgs/issues/65434
    unpackPhase = ":";

    # Dependencies https://github.com/mov-cli/mov-cli?tab=readme-ov-file#prerequisites
    propagateBuildInputs = [
      pythonEnv
      pkgs.fzf
      pkgs.mpv
      pkgs.ffmpeg
      pkgs.libxml2
    ];

    installPhase = ''
      mkdir -p $out/bin

      cat > $out/bin/mov-cli <<EOF
      #!${pkgs.runtimeShell}
      CONFIG_HOME="\$HOME/.config/mov-cli"
      if [ ! -e "\$CONFIG_HOME/config.toml" ]; then
        mkdir -p "\$CONFIG_HOME"
      fi

      ln -sf "${config}" "\$CONFIG_HOME/config.toml"

      export PYTHONPATH=${pythonEnv}/${python.sitePackages}
      ${mov-cli}/bin/mov-cli "\$@"
      EOF

      chmod +x $out/bin/mov-cli
    '';
  }
