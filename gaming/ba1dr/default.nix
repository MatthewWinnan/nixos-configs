{pkgs, ...}: {
  imports = [
    ./opengl.nix
    ./video_drivers.nix
  ];
}
