# Good DOCS for setting this up -> https://nixos.org/manual/nixpkgs/stable/#python
{pkgs}: let
  pythonPackages = pkgs.python312Packages;
  pyPkgs = pythonPackages:
    with pythonPackages; [
      pip
      venvShellHook
      ipython
      setuptools

      # Packages I need to develop with
      paramiko
      pyyaml
      robotframework
      flask
      urllib3
      bravado-core
      numpy

      # This is for LSP uses
      pylint
      pyflakes
      pylsp-rope
      ruff-lsp

      # This is for styling, hard to conform now drop it
      #pycodestyle
      pydocstyle
      black
    ];
in
  pkgs.mkShell rec {
    venvDir = "./.venv";

    buildInputs = [
      pkgs.python312
      (pkgs.python312.withPackages pyPkgs)
    ];

    shellHook = ''
      echo "Python development environment"

      # Set environment variables
      # export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"
      # export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
      # export PYTHONUSERBASE="$XDG_DATA_HOME/python"
      # export PYTHON_EGG_CACHE="$XDG_CACHE_HOME/python-eggs"
      # export PYTHONHISTFILE="$XDG_DATA_HOME/python/python_history"
      # export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
      # export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
      # export PIP_CONFIG_FILE="$XDG_CONFIG_HOME/pip/pip.conf"
      # export PIP_LOG_FILE="$XDG_STATE_HOME/pip/log"
      # export PYLINTHOME="$XDG_DATA_HOME/pylint"
      # export PYLINTRC="$XDG_CONFIG_HOME/pylint/pylintrc"
      # export WORKON_HOME="$XDG_DATA_HOME/virtualenvs"


      if [ -d "${venvDir}" ]; then
        echo "Skipping venv creation, '${venvDir}' already exists"
      else
        echo "Creating new venv environment in path: '${venvDir}'"
        # Note that the module venv was only introduced in python 3, so for 2.7
        # this needs to be replaced with a call to virtualenv
        ${pythonPackages.python.interpreter} -m venv "${venvDir}"
      fi

      # Under some circumstances it might be necessary to add your virtual
      # environment to PYTHONPATH, which you can do here too;
      # PYTHONPATH=$PWD/${venvDir}/${pythonPackages.python.sitePackages}/:$PYTHONPATH

      source "${venvDir}/bin/activate"
    '';

    postVenvCreation = ''
      unset SOURCE_DATE_EPOCH
      pip install -r requirements.txt
    '';

    postShellHook = ''
      # Allow pip ro install wheels
      unset SOURCE_DATE_EPOCH
    '';
  }
