{pkgs, ...}:
{
  services.xserver.videoDrivers = ["nvidia"];

  # This part is already done by https://github.com/NixOS/nixos-hardware/blob/master/lenovo/legion/15ich/default.nix
  # hardware.nvidia.modesetting.enable = true;

  # Further it always configures nvidia prime for me, I do need to enable some things
  hardware.nvidia.prime = {
    sync.enable = true;
    offload.enable = false;
  };
}
