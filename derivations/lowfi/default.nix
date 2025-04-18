# shell.nix or within a flake
{pkgs ? import <nixpkgs> {}}: let
  lowfi = pkgs.callPackage ./lowfi.nix {};
in
  pkgs.mkShell {
    buildInputs = [lowfi];
  }
