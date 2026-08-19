{pkgs, ...}: {
  imports = [
    ./opengl.nix
    ./video_drivers.nix
    ../modules
    # OpenRGB — apply lighting profile at boot
    ./openrgb
  ];
}
