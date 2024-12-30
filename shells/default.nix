{ pkgs, system, lib, stdenvNoCC, runCommand, fetchgit, zephyr, ...}:

{
  python = import ./python.nix {inherit pkgs;};
  taskit = import ./taskit_dev.nix {inherit pkgs;};
  arduino = import ./arduino.nix {inherit pkgs;};
  keymap_editor = import ./keymap_editor.nix {inherit pkgs;};
  zypher = import ./zypher/default.nix {inherit pkgs system lib stdenvNoCC runCommand fetchgit zephyr;};
}
