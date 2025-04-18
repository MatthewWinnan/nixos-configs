{pkgs ? import <nixpkgs> {}}: let
  himalaya = pkgs.callPackage ./himalaya.nix {};
in
  pkgs.mkShell {
    buildInputs = [himalaya];
  }
