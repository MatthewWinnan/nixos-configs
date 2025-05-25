{
  lib,
  python3Packages,
  fetchPypi,
  quickjs,
}:
python3Packages.buildPythonPackage rec {
  pname = "quickjs";
  version = "1.19.4";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-EgWVOrwk/3V/SnlTBNXWHkvx5VXJ727JahMtS5VTVIQ=";
  };

  propagateBuildInputs = [
    quickjs
  ];

  build-system = with python3Packages; [
    wheel
    setuptools
  ];

  pythonImportsCheck = [
    "quickjs"
  ];

  meta = {
    description = "Wrapping the quickjs C library";
    homepage = "https://pypi.org/project/quickjs/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [];
  };
}
