# For nixOS specific imports
{ inputs, ... }:
{
  imports = [
    # Hardware declarations
    ./hardware-configuration.nix
    # Import nixOS settings
    ../../../nix/headless
    # Settings
    ../settings
    # Boot settings
    ./boot.nix
    # Secrets management
    ./sops.nix
    # Tailscale for mesh networking (with routing features)
    ./tailscale.nix
    # Caddy reverse proxy with Tailscale integration
    ../../../nix/services/caddy-proxy
    # Authelia authentication server
    ../../../nix/services/authelia
  ];
}
