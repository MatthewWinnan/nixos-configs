# Caddy reverse proxy with Tailscale Funnel
#
# Architecture:
#   Internet → Tailscale Funnel (TLS termination) → Caddy (HTTP) → Backend
#
# Tailscale handles certificates automatically (Let's Encrypt for *.ts.net)
{
  config,
  pkgs,
  ...
}:
let
  # Custom Caddy with defender plugin
  caddyCustom = pkgs.caddy.withPlugins {
    plugins = [
      "pkg.jsn.cam/caddy-defender@v0.10.0"
    ];
    hash = "sha256-uucD7cwXlZBA3FbxP6ep0Ysz2LcDBpb4Q/gHuqtcWG8=";
  };

  localPort = 8080;
  funnelPort = 443;

  # Landing page directory in nix store
  landingPageDir = ./landing-page;
in
{
  # Caddy reverse proxy (HTTP only - Tailscale handles TLS)
  services.caddy = {
    enable = true;
    package = caddyCustom;

    globalConfig = ''
      admin off
    '';

    extraConfig = ''
      :${toString localPort} {
        # Block AI crawlers (available: openai, deepseek, githubcopilot, aws, gcloud, etc.)
        defender block {
          ranges openai deepseek githubcopilot
        }

        # Serve landing page at root
        @root path /
        handle @root {
          root * ${landingPageDir}
          try_files /index.html
          file_server
        }

        # Home Assistant proxy
        handle /ha/* {
          uri strip_prefix /ha
          reverse_proxy {$HA_BACKEND} {
            header_up Host {upstream_hostport}
            header_up X-Forwarded-Proto https
          }
        }

        # Jellyfin media server proxy
        # Note: Set Jellyfin's base URL to "/media" in Admin > Networking
        redir /media /media/
        reverse_proxy /media/* {$JELLYFIN_BACKEND} {
          header_up Host {upstream_hostport}
          header_up X-Forwarded-Proto https
        }

        # Default: proxy to Home Assistant
        # HA frontend makes requests to /api/*, /frontend_latest/*, etc.
        handle {
          reverse_proxy {$HA_BACKEND} {
            header_up Host {upstream_hostport}
            header_up X-Forwarded-Proto https
          }
        }
      }
    '';
  };

  # Load backend address from sops secret
  systemd.services.caddy.serviceConfig.EnvironmentFile = [
    config.sops.secrets."caddy-env".path
  ];

  # Tailscale Funnel service
  systemd.services.tailscale-funnel = {
    description = "Tailscale Funnel for Caddy proxy";
    after = [
      "tailscaled.service"
      "caddy.service"
      "network-online.target"
    ];
    wants = [
      "tailscaled.service"
      "network-online.target"
    ];
    wantedBy = [ "multi-user.target" ];

    path = [
      pkgs.tailscale
      pkgs.jq
    ];

    preStart = ''
      # Wait for tailscale to be ready
      until tailscale status --json | jq -e '.BackendState == "Running"' > /dev/null 2>&1; do
        sleep 1
      done
    '';

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      # tailscale funnel exposes to public internet
      ExecStart = "${pkgs.tailscale}/bin/tailscale funnel --bg --https=${toString funnelPort} http://127.0.0.1:${toString localPort}";
      ExecStop = "${pkgs.tailscale}/bin/tailscale funnel --https=${toString funnelPort} off";
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };

  # Firewall - only local port needed, Tailscale handles external
  networking.firewall.allowedTCPPorts = [ localPort ];
}
