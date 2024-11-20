# This is a specific environment for my TaskIT project.
# The nodejs is needed for dockerls please see:
# 1) https://nix-community.github.io/nixvim/plugins/lsp/servers/dockerls/index.html
# 2) https://nix-community.github.io/nixvim/plugins/lsp/servers/docker_compose_language_service/index.html
#
# Good DOCS for setting this up -> https://nixos.org/manual/nixpkgs/stable/#python

{ pkgs }:
let
  pythonPackages = pkgs.python312Packages;
  pyPkgs = pythonPackages: with pythonPackages; [
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

            # This is for styling, hard to conform now drop it
            #pycodestyle
            pydocstyle
            black
  ];
in
pkgs.mkShell rec {
  venvDir = "./.taskit_venv";

  buildInputs = [
      pkgs.python312
      pkgs.nodejs_20
      pkgs.docker-compose-language-service
      pkgs.dockerfile-language-server-nodejs
      pkgs.docker-compose
      pkgs.docker
      (pkgs.python312.withPackages pyPkgs)
    ];

  shellHook = ''
    echo "TaskIT development environment"

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

    # Now we install our node things
    npm install @microsoft/compose-language-service
    npm install dockerfile-language-server-nodejs
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
