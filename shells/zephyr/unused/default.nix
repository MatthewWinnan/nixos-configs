# Good DOCS for zmk setup can be found here
# https://zmk.dev/docs/development/local-toolchain/setup/native
# We also need to install zypher according to this
# https://docs.zephyrproject.org/3.5.0/develop/getting_started/index.html
{
  pkgs,
  system,
  lib,
  stdenvNoCC,
  runCommand,
  fetchgit,
  zephyr,
  ...
}: let
  pythonPackages = pkgs.python312Packages;
  pyPkgs = pythonPackages:
    with pythonPackages; [
      pip
      venvShellHook
      ipython
      setuptools
      west
      pyelftools
      pyyaml
      packaging
      progress
      anytree
      intelhex
    ];

  # We need 32-bit support
  stdenv =
    if pkgs.stdenv.hostPlatform.isLinux
    then pkgs.multiStdenv
    else pkgs.stdenv;

  # We need to add the sdk elements
  # I tried paching it myself, I need a way to pathch the ELF so I can use it withint nixos,
  # instead I am using the solution in https://github.com/adisbladis/zephyr-nix/tree/master,
  # worth checking how they patch it, feels like I am close??
  #zephyr_sdk = import ./zephyr-sdk.nix { inherit pkgs; }

  # Add the source for Zephyr
  zephyr_source = import ./zephyr.nix {inherit lib stdenvNoCC runCommand fetchgit;};
in
  stdenv.mkDerivation rec {
    name = "zmk-shell";

    venvDir = "./.zephyr_venv";

    buildInputs = [
      # Python Env Dependencies
      pkgs.python312
      (pkgs.python312.withPackages pyPkgs)

      # ZMK Dependencies
      pkgs.cmake
      pkgs.ninja
      pkgs.gitFull
      pkgs.wget
      pkgs.autoconf
      pkgs.automake
      pkgs.bzip2
      pkgs.ccache
      pkgs.dtc # devicetree compiler
      pkgs.dfu-util
      pkgs.gcc
      pkgs.glibc
      pkgs.zlib
      pkgs.libstdcxx5
      pkgs.libtool
      pkgs.xz
      pkgs.jq

      # ARM toolchain
      pkgs.gcc-arm-embedded

      # Zephyr toolchains
      zephyr_source

      (zephyr.sdk.override {
        targets = [
          "arm-zephyr-eabi"
        ];
      })
      zephyr.pythonEnv
      # Use zephyr.hosttools-nix to use nixpkgs built tooling instead of official Zephyr binaries
      zephyr.hosttools
    ];

    shellHook = ''

      echo "ZMK development environment"

      if [ -d "${venvDir}" ]; then
          echo "Skipping venv creation, '${venvDir}' already exists"
      else
          echo "Creating new venv environment in path: '${venvDir}'"
          # Note that the module venv was only introduced in python 3, so for 2.7
          # this needs to be replaced with a call to virtualenv
          ${pythonPackages.python.interpreter} -m venv "${venvDir}"
      fi

      source "${venvDir}/bin/activate"

      # Setup env variables
      # export ZEPHYR_TOOLCHAIN_VARIANT="gnuarmemb"
      # export GNUARMEMB_TOOLCHAIN_PATH="${pkgs.gcc-arm-embedded}"

      # Clone the ZMK firmware repository if it doesn't already exist
      if [ ! -d "zmk-facehugger" ]; then
        echo "Cloning Personal ZMK repository..."
        git clone https://github.com/MatthewWinnan/zmk-facehugger.git
      else
        echo "ZMK repository already exists."
      fi

      cd zmk-facehugger/;

      # Next we want to setup west
      if [ ! -d ".west" ]; then
        west init -l app/;
      else
        echo "WEST is already initialized."
      fi

      # Some west functions that need to always be written
      west update;
      west zephyr-export;
      west config build.cmake-args -- "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON"

      # Setup the needed python packages for zephyr
      pip install -r zephyr/scripts/requirements.txt;

      # Now if the build does exist we can symlink the compile_commands
      if [ -d "build" ]; then
        ln -s build/compile_commands.json .;
      else
        echo "There has been no builds yet, as such can not symlink compile_commands";
      fi
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
