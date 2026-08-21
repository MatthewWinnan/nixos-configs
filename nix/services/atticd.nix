# Attic - self-hosted Nix binary cache
#
# Docs: https://docs.attic.rs/admin-guide/deployment/nixos.html
#
# Runs on th0r rather than ba1dr: a cache needs disk headroom and ba1dr's is
# committed to the media library. th0r has ~193G free.
#
# Reachable over the tailnet only. atticd binds all interfaces, but the
# firewall does not open 8080 - tailscale0 is a trusted interface
# (nix/services/tailscale.nix), so tailnet peers reach it and the WAN cannot.
#
# Deliberately NOT behind Caddy/Authelia: attic authenticates with its own
# JWT tokens, and an Authelia forward-auth in front would break `nix copy` and
# substitution, which cannot complete an interactive login.
{
  config,
  pkgs,
  ...
}: let
  # NOT 8080: caddy-proxy already binds that on th0r and tailscale funnel
  # forwards public traffic to 127.0.0.1:8080. Colliding there would break the
  # public ingress.
  port = 8081;
  # Clients reach the server by its MagicDNS name. attic embeds this in the
  # cache URLs it hands out, so it must match what clients actually use.
  endpoint = "http://th0r:${toString port}/";
in {
  services.atticd = {
    enable = true;

    # Single node: run the API server, garbage collector and all else together.
    mode = "monolithic";

    # Provides ATTIC_SERVER_TOKEN_RS256_SECRET_BASE64, the RS256 JWT signing
    # key. Generate with:
    #   nix run nixpkgs#openssl -- genrsa -traditional 4096 | base64 -w0
    environmentFile = config.sops.secrets."atticd-env".path;

    settings = {
      listen = "[::]:${toString port}";
      api-endpoint = endpoint;

      # Signing keys for the caches themselves are generated per-cache at
      # runtime; this block just has to exist.
      jwt = {};

      # Content-defined chunking, so NARs that differ slightly still share
      # most of their storage. Values are the upstream recommended defaults.
      chunking = {
        nar-size-threshold = 65536; # chunk anything >= 64 KiB
        min-size = 16384; # 16 KiB
        avg-size = 65536; # 64 KiB
        max-size = 262144; # 256 KiB
      };

      compression = {
        type = "zstd";
      };

      garbage-collection = {
        interval = "12 hours";
        # Objects no client has asked for in this long become eligible. Only
        # applies to caches configured with a retention period.
        default-retention-period = "6 months";
      };
    };
  };

  # attic-client, for `attic login` / `attic push` / `attic use`.
  environment.systemPackages = [pkgs.attic-client];
}
