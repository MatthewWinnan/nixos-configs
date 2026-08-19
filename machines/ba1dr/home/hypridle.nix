# Disable hypridle entirely for media server use
# ba1dr runs Jellyfin and should stay awake 24/7 with no idle actions at all
{lib, ...}: {
  services.hypridle.enable = lib.mkForce false;
}
