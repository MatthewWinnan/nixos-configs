{ pkgs }:

pkgs.mkShell {
    # packages = [ pythonPackages ];
  venvDir = ".venv";
   packages = with pkgs;
          [python312]
          ++ (with pkgs.python312Packages; [
            pip
            venvShellHook
            ipython
            black
            setuptools
            pylint
    ]);

  shellHook = ''
    echo "Python development environment"

    # Set environment variables
    export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"
    export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
    export PYTHONUSERBASE="$XDG_DATA_HOME/python"
    export PYTHON_EGG_CACHE="$XDG_CACHE_HOME/python-eggs"
    export PYTHONHISTFILE="$XDG_DATA_HOME/python/python_history"
    export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
    export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
    export PIP_CONFIG_FILE="$XDG_CONFIG_HOME/pip/pip.conf"
    export PIP_LOG_FILE="$XDG_STATE_HOME/pip/log"
    export PYLINTHOME="$XDG_DATA_HOME/pylint"
    export PYLINTRC="$XDG_CONFIG_HOME/pylint/pylintrc"
    export WORKON_HOME="$XDG_DATA_HOME/virtualenvs"

  '';
}
