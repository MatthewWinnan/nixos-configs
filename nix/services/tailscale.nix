{
  pkgs,
  lib,
  config,
  ...
}: {
  services.tailscale = lib.mkIf (config.systemSettings.profile != "work") {
    enable = true;
    useRoutingFeatures = "client";
    openFirewall = true;
  };

  networking.firewall = lib.mkIf (config.systemSettings.profile != "work") {
    trustedInterfaces = ["tailscale0"];
    allowedUDPPorts = [config.services.tailscale.port];
  };
}
