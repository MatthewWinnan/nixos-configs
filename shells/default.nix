{ pkgs, system, lib, stdenvNoCC, runCommand, fetchgit, zephyr, pkgs_stable, ...}:

{
  python = import ./python.nix {inherit pkgs;};
  taskit = import ./taskit_dev.nix {inherit pkgs;};
  arduino = import ./arduino.nix {inherit pkgs;};
  keymap_editor = import ./keymap_editor.nix {inherit pkgs;};
  zephyr = import ./zephyr/default.nix {inherit pkgs system lib stdenvNoCC runCommand fetchgit zephyr;};
  zmk = import ./zephyr/zmk.nix {inherit pkgs system lib stdenvNoCC runCommand fetchgit zephyr;};

  # With NixOS 25.04 I am getting buffer overflow issues, and it does not support libstdcxx5, we pin it to pkgs_stable, which is guarenteed to work
  zmk_kyria = import ./zephyr/zmk_kyria.nix {
    inherit pkgs system lib stdenvNoCC runCommand fetchgit;
    zephyr=zephyr;
    pkgs_stable = pkgs_stable;
  };

  freecad = import ./freecad.nix {inherit pkgs;};
}
