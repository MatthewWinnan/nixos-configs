{pkgs, ...}: {
  imports = [
    ./binfmt.nix
    ./docker.nix
    ./podman.nix
  ];
}
