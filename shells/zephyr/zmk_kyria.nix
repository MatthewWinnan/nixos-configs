# Good DOCS for zmk setup can be found here
# https://zmk.dev/docs/development/local-toolchain/setup/native
# Most of the Zypher things will be installed by the package zephyr
# The the typical use case for the shell is to just be able to compile one of my ZMK boards

{pkgs, system, lib, stdenvNoCC, runCommand, fetchgit, zephyr, ... }:
let
  pythonPackages = pkgs.python312Packages;
  pyPkgs = pythonPackages: with pythonPackages; [
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
  stdenv = if pkgs.stdenv.hostPlatform.isLinux then pkgs.multiStdenv else pkgs.stdenv;

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

    echo "KYRIA Rev3 Development Environment"

    if [ -d "${venvDir}" ]; then
        echo "Skipping venv creation, '${venvDir}' already exists"
    else
        echo "Creating new venv environment in path: '${venvDir}'"
        # Note that the module venv was only introduced in python 3, so for 2.7
        # this needs to be replaced with a call to virtualenv
        ${pythonPackages.python.interpreter} -m venv "${venvDir}"
    fi

    source "${venvDir}/bin/activate"

    # Clone the Kyria Config repository if it doesn't already exist
    if [ ! -d "kyria_zmk_config" ]; then
      echo "Cloning Personal Kyria repository..."
      git clone https://github.com/MatthewWinnan/kyria_zmk_config.git
    else
      echo "Kyria repository already exists."
    fi

    # Move into the directory
    cd kyria_zmk_config/

    # We need to establish if this is the first time west has been used, thus has it been initialized
    if [ -d ".west" ]; then
      echo "West has been initialized.";
    else
      echo "West has not been initialized. Initializing";
      west init -l config/;
    fi

    # We always need to update
    west update;

    # Setup the needed python packages for zephyr
    pip install -r kyria_zmk_config/zephyr/scripts/requirements.txt;

    # Export runtime variables
    west zephyr-export;

    # Configure the cmake exports, we can use west config -l to see if this is done, but complex bash is annoying
    west config build.cmake-args -- "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DZMK_CONFIG=/home/matthew/KYRIA_CONF/kyria_zmk_config/config"

    # Now if the build does exist we can symlink the compile_commands
    if [ ! -d "build" ]; then
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
