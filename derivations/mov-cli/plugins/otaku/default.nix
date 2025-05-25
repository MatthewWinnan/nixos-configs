{
  lib,
  fetchFromGitHub,
  quickjs,
  python3,
  callPackage,
}:
python3.pkgs.buildPythonPackage rec {
  pname = "otaku-watcher-contrib";
  version = "unstable-2025-03-12";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "GDjkhp";
    repo = "otaku-watcher-contrib";
    rev = "b349f36d676889844f2f0081e7bd1cd286e05307";
    hash = "sha256-64L9TT4MsxhUK/Z0dqh9lAApKfS8Cxd7YkrTiK/F4sQ=";
  };

  build-system = [
    python3.pkgs.setuptools
  ];

  buildInputs = [quickjs];

  dependencies = [quickjs];

  propagatedBuildInputs = with python3.pkgs; [
    (callPackage ../../mov-cli {})
    (callPackage ../../packages/quickjs.nix {})
    requests
    thefuzz
    importlib-metadata
  ];

  optional-dependencies = with python3.pkgs; {
    dev = [
      build
      ruff
    ];
  };

  pythonImportsCheck = [
    "otaku_watcher_contrib"
  ];

  meta = {
    description = "A mov-cli plugin for watching anime and more";
    homepage = "https://github.com/GDjkhp/otaku-watcher-contrib";
    license = lib.licenses.wtfpl;
    maintainers = with lib.maintainers; [];
  };
}
