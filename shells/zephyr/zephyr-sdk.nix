# A lot of the contents in this script comes from https://www.ericjjohnson.dev/blog/nix-with-zephyr-rtos/
{
  pkgs ? import <nixpkgs> {},
  system ? pkgs.stdenv.system,
}:
with pkgs; let
  pname = "zephyr-sdk";
  version = "0.16.8";

  # SDK uses slightly different system names, use this variable to fix them up for use in the URL
  system_fixup = {
    x86_64-linux = "linux-x86_64";
    aarch64-linux = "linux-aarch64";
    x86_64-darwin = "macos-x86_64";
    aarch64-darwin = "macos-aarch64";
  };

  # Use the minimal installer as starting point
  url = "https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v${version}/${pname}-${version}_${system_fixup.${system}}_minimal.tar.xz";
in
  stdenvNoCC.mkDerivation {
    inherit pname version;

    # Allows derivation to access network
    #
    # This is needed due to the way setup.sh works with the minimal toolchain. The script uses wget to retrieve the
    # specific toolchain variants over the network.
    #
    # Users of this package must set options to indicate that the sandbox conditions can be relaxed for this package.
    # These are:
    # - In the appropriate nix.conf file (depends on multi vs single user nix installation), add the line: sandbox = relaxed
    # - When used in a flake, set the flake's config with this line: nixConfig.sandbox = "relaxed";
    # - Same as above, but disabling the sandbox completely: nixConfig.sandbox = false;
    # - From the command line with nix <command>, add one of these options:
    #   - --option sandbox relaxed
    #   - --option sandbox false
    #   - --no-sandbox
    #   - --relaxed-sandbox
    __noChroot = true;

    name = "zephyr-sdk-0.16.3";

    src = pkgs.fetchurl {
      url = url;
      sha256 = "sha256-wyOvzSIUnvDyF3WaR4v4s6QtLjbIm2U6C4dduI12d+Q="; # Replace with the correct sha256 checksum
    };

    # Our source is right where the unzip happens, not in a "src/" directory (default)
    sourceRoot = ".";

    nativeBuildInputs = [pkgs.autoPatchelfHook]; # Enable auto-patching for dynamic binaries

    buildInputs = [
      pkgs.gzip
      pkgs.cacert
      pkgs.which
      pkgs.wget
      pkgs.cmake
      pkgs.dtc # devicetree compiler
      pkgs.dfu-util
      pkgs.gcc
      pkgs.glibc
      pkgs.zlib
      pkgs.libstdcxx5
      pkgs.libtool
      pkgs.gcc-arm-embedded
    ];

    # Required to prevent CMake running in configuration phases
    dontUseCmakeConfigure = true;

    phases = ["unpackPhase" "buildPhase" "installPhase"];

    unpackPhase = ''
      mkdir -p $TMPDIR
      tar -xvf $src -C $TMPDIR
    '';

    buildPhase = ''
      bash $TMPDIR/${pname}-${version}/setup.sh -t arm-zephyr-eabi
    '';

    installPhase = ''
      mkdir -p $out
      mv $TMPDIR/* $out/
    '';

    # Automatically patch binaries for correct linker and library paths
    autoPatchelfIgnoreMissingDeps = true; # Ignore missing dependencies during auto-patching
  }
