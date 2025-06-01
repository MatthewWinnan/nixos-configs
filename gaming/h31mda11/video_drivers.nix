{pkgs, ...}: {
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia.modesetting.enable = true;

  # Further it always configures nvidia prime for me, I do need to enable some things
  hardware.nvidia.prime = {
    sync.enable = true;
    offload.enable = false;
  };
}
