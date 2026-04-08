# sops-nix secrets configuration for th0r
{
  config,
  lib,
  ...
}: {
  sops = {
    defaultSopsFile = ../../../secrets/th0r.yaml;

    age = {
      sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    };

    secrets = {
      # Caddy environment variables
      # Contains:
      #   HA_BACKEND=<host>:<port>
      #   JELLYFIN_BACKEND=<host>:<port>
      "caddy-env" = {
        mode = "0400";
      };
    };
  };
}
