# OpenRGB — auto-apply profile at boot and on resume from suspend
{pkgs, ...}: {
  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
    motherboard = "amd";
  };

  # Apply saved profile at boot (and after resume)
  systemd.services.openrgb-profile = {
    description = "Apply OpenRGB lighting profile";
    after = ["openrgb.service" "post-resume.target"];
    wants = ["openrgb.service"];
    wantedBy = ["multi-user.target" "post-resume.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 3";
      ExecStart = "${pkgs.openrgb-with-all-plugins}/bin/openrgb --profile ${./antec_cx800.orp}";
    };
  };
}
