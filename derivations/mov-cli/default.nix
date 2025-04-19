{
  lib,
  fetchFromGitHub,
  ffmpeg,
  fzf,
  mpv,
  python3,
}: let
  pname = "mov-cli";
  version = "4.4.19";
in
  python3.pkgs.buildPythonPackage {
    inherit pname version;
    pyproject = true;

    src = fetchFromGitHub {
      owner = "mov-cli";
      repo = "mov-cli";
      tag = version;
      hash = "sha256-sNeScHmQYR4Avr5OEFpE90Qn7udBgi1Ox5elFSyKXrY=";
    };

    doCheck = false;

    propagatedBuildInputs = with python3.pkgs; [
      beautifulsoup4
      click
      colorama
      deprecation
      httpx
      inquirer
      krfzf-py
      lxml
      poetry-core
      pycrypto
      python-decouple
      setuptools
      six
      thefuzz
      tldextract
      toml
      typer
      unidecode
      # On default the pyproject.toml has this as a dependency so we need to build it
      (callPackage ./mov-cli-test.nix {})
    ];

    pythonRelaxDeps = [
      "httpx"
      "tldextract"
    ];

    makeWrapperArgs = let
      binPath = lib.makeBinPath [
        ffmpeg
        fzf
        mpv
      ];
    in [
      "--prefix PATH : ${binPath}"
    ];

    meta = with lib; {
      homepage = "https://github.com/mov-cli/mov-cli";
      description = "Cli tool to browse and watch movies";
      license = with lib.licenses; [gpl3Only];
      mainProgram = "mov-cli";
      maintainers = with lib.maintainers; [baitinq];
    };
  }
