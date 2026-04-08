# Disable hypridle suspend for media server use
# ba1dr runs Jellyfin and should stay awake 24/7
{ lib, ... }:
{
  services.hypridle = {
    settings = {
      # Override listeners - remove suspend, keep only screen lock/dpms
      listener = lib.mkForce [
        {
          timeout = 600; # 10 min
          on-timeout = "hyprlock";
        }
        {
          timeout = 900; # 15 min
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 1200; # 20 min
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        # No suspend listener - server stays awake
      ];
    };
  };
}
