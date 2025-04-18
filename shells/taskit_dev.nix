# This is a specific environment for my TaskIT project.
# The nodejs is needed for dockerls please see:
# 1) https://nix-community.github.io/nixvim/plugins/lsp/servers/dockerls/index.html
# 2) https://nix-community.github.io/nixvim/plugins/lsp/servers/docker_compose_language_service/index.html
#
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
      matplotlib
      scipy
      pandas
      pem
      gspread
      google-api-python-client
      oauth2client
      beautifulsoup4
      netifaces

      # This is for LSP uses
      pylint
      pyflakes
      ruff-lsp
      #pylsp-rope

      # This is for styling, hard to conform now drop it
      #pycodestyle
      pydocstyle
      black
    ];

  # Create the docker start script
  docker-rootless-script = ''
    # Now we have to configure docker
    echo "Configuring rootless docker daemon"

    if pgrep -x rootlesskit > /dev/null; then
      echo "dockerd-rootless is already running"
    else
      nohup dockerd-rootless > /tmp/dockerd-rootless.log 2>&1 & disown
      echo "dockerd-rootless started in the background"
    fi
  '';
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
      pkgs.nix-prefetch-docker
      #pkgs.dockerTools
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
      PYTHONPATH=$PWD/${venvDir}/${pythonPackages.python.sitePackages}/:$PYTHONPATH

      source "${venvDir}/bin/activate"

      # Now we install our node things
      echo "Configuring docker LSP"
      echo "Verifying internet access"

      if ping -c 1 8.8.8.8 &> /dev/null
      then
        npm install @microsoft/compose-language-service > /tmp/npm_taskit.log 2>&1
        npm install dockerfile-language-server-nodejs >> /tmp/npm_taskit.log 2>&1
      else
        echo "Could not install docker LSP NPM packages due to no internet"
      fi

      script_path="$PWD/docker-rootless-script.sh"
      echo "Writing docker start script to: $script_path"
      echo "${docker-rootless-script}" > "$script_path"
      chmod +x "$script_path"

      # Export the socket
      export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
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
