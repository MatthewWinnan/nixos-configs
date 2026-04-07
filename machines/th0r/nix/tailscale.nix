# Tailscale configuration for th0r (proxy server)
# Overrides the default client-only config with routing capabilities
{
  pkgs,
  lib,
  config,
  ...
}:
{
  services.tailscale = lib.mkForce {
    enable = true;
    # "both" allows th0r to:
    # - Use exit nodes/subnet routes (client)
    # - Advertise routes or act as exit node (server)
    useRoutingFeatures = "both";
    openFirewall = true;
  };

  networking.firewall = {
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
  };
}
