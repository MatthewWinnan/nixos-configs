{
  pkgs,
  config,
  ...
}: {
  services.xserver.videoDrivers = ["nvidia"];

  # Official guide https://nixos.wiki/wiki/Nvidia
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    modesetting.enable = true;

    # So If you have an GPU with Turing architecture (RTX 20-Series) or newer set hardware.nvidia.open to true.
    open = true;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`
    nvidiaSettings = true;

    # Nvidia power management. Enabled because resuming from hypridle's 30 min
    # `systemctl suspend` came back to a black screen: the session was alive and
    # logged in, but nothing rendered. With this false there are no
    # nvidia-suspend/nvidia-resume units at all, so VRAM contents are not saved
    # or restored across suspend and the display never recovers.
    # Costs a write of VRAM to disk on each suspend.
    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;
  };
}
