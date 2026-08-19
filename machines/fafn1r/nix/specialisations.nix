# NixOS specialisations for fafn1r
# Both "work" and "home" profiles are built simultaneously.
# Select at boot from the bootloader menu, or switch live:
#   sudo /run/current-system/specialisation/home/bin/switch-to-configuration switch
#   sudo /run/current-system/specialisation/work/bin/switch-to-configuration switch
{lib, ...}: {
  specialisation = {
    work.configuration = {
      deviceSettings.monitors = lib.mkForce [
        {
          name = "Virtual-1";
          width = 1920;
          height = 1080;
          workspace = "1";
          primary = true;
          refreshRate = 60.00;
        }
      ];
      deviceSettings.location = lib.mkForce "work";
    };

    home.configuration = {
      deviceSettings.monitors = lib.mkForce [
        {
          name = "Virtual-1";
          width = 3440;
          height = 1440;
          workspace = "1";
          primary = true;
          refreshRate = 60.00;
        }
      ];
      deviceSettings.location = lib.mkForce "home";

      # At home, don't need the hyperv_fb kernel param for ultrawide
      # (adjust if needed — keeping it doesn't hurt)
      boot.kernelParams = lib.mkForce ["video=hyperv_fb:3440x1440"];
    };
  };
}
