{inputs, ...}: {
  imports = [
    ./packages
    ./packages/security-overlay.nix
    ./tools
    ./desktop
    ./gui
    ./nixvim
  ];
}
