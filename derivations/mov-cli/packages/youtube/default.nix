{
  lib,
  python3,
  fetchFromGitHub,
  callPackage,
}:
python3.pkgs.buildPythonPackage rec {
  pname = "mov-cli-youtube";
  version = "1.3.8";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "mov-cli";
    repo = "mov-cli-youtube";
    rev = version;
    hash = "sha256-2dc6EYy+6vCOCy+FZBVKWzeV3xFAswUaX9XfYk0jz1E=";
  };

  build-system = [
    python3.pkgs.setuptools
  ];

  disabledTestPaths = [
    # Tests require network access
    "tests/test_captions.py"
    "tests/test_cli.py"
    "tests/test_exceptions.py"
    "tests/test_extract.py"
    "tests/test_main.py"
    "tests/test_query.py"
    "tests/test_streams.py"
  ];

  disabledTests = [
    "test_playlist_failed_pagination"
    "test_playlist_pagination"
    "test_create_mock_html_json"
  ];

  patchPhase = ''
    echo "Replacing pyproject.toml with custom version..."
    cp ${./pyproject.toml} ./pyproject.toml
  '';

  dependencies = with python3.pkgs; [
    (callPackage ../mov-cli {})
  ];

  propagatedBuildInputs = with python3.pkgs; [
    importlib-metadata
    (callPackage ./packages/yt-dlp.nix {})
    requests
  ];

  optional-dependencies = with python3.pkgs; {
    dev = [
      build
      ruff
    ];
  };

  pythonImportsCheck = [
    "mov_cli_youtube"
  ];

  meta = {
    description = "A mov-cli v4 plugin for watching youtube";
    homepage = "https://github.com/mov-cli/mov-cli-youtube";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [];
    mainProgram = "mov-cli-youtube";
  };
}
