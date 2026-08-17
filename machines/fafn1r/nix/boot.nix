{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # Tell the Hyper-V framebuffer driver to use the full VM display resolution.
    # Without this, hyperv_fb defaults to a lower mode and Hyprland cannot find
    # a matching mode for the configured 3440x1440 monitor.
    kernelParams = ["video=hyperv_fb:3440x1440"];
  };
}
