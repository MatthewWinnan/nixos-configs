{
  system,
  inputs,
  ...
}:
let
  # Pkgs impots
  pkgs = inputs.nixpkgs.legacyPackages.${system};
  pkgs_stable = inputs.nixpkgs-stable.legacyPackages.${system};

  # General imports
  stdenvNoCC = inputs.nixpkgs.legacyPackages.${system}.stdenvNoCC;
  zephyr = inputs.zephyr-nix.packages.${system};

  inherit (pkgs) lib runCommand fetchgit;
in
{
  python = import ./python.nix {inherit pkgs;};
  taskit = import ./taskit_dev.nix {inherit pkgs;};
  arduino = import ./arduino.nix {inherit pkgs;};
  keymap_editor = import ./keymap_editor.nix {inherit pkgs;};
  freecad = import ./freecad.nix {inherit pkgs;};

  # With NixOS 25.04 I am getting buffer overflow issues, and it does not support libstdcxx5, we pin it to pkgs_stable, which is guarenteed to work
  zmk = import ./zephyr/zmk.nix {inherit system lib stdenvNoCC runCommand fetchgit zephyr;
      pkgs_stable = pkgs_stable;
};
  zmk_kyria = import ./zephyr/zmk_kyria.nix {
    inherit pkgs system lib stdenvNoCC runCommand fetchgit;
    zephyr = zephyr;
    pkgs_stable = pkgs_stable;
  };

}
