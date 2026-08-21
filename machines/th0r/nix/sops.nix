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
      #   JELLYSEERR_BACKEND=<host>:<port>
      "caddy-env" = {
        mode = "0400";
      };

      # Authelia secrets
      "authelia-jwt-secret" = {
        mode = "0400";
        owner = "authelia-main";
      };
      "authelia-session-secret" = {
        mode = "0400";
        owner = "authelia-main";
      };
      "authelia-storage-encryption-key" = {
        mode = "0400";
        owner = "authelia-main";
      };
      # Users file in YAML format (see secrets/authelia-users-example.yaml)
      "authelia-users" = {
        mode = "0400";
        owner = "authelia-main";
      };

      # Attic binary cache. Read by atticd as an EnvironmentFile, so it must
      # be shell-assignment syntax, not YAML-nested:
      #   ATTIC_SERVER_TOKEN_RS256_SECRET_BASE64="<base64 blob>"
      # Generate the blob with:
      #   nix run nixpkgs#openssl -- genrsa -traditional 4096 | base64 -w0
      # Owned by root: systemd reads EnvironmentFile before dropping to the
      # atticd user, and the RS256 key signs every cache token.
      "atticd-env" = {
        mode = "0400";
      };
    };
  };
}
