# Authelia authentication server
#
# Provides forward-auth for Caddy reverse proxy.
# Users still login to individual services (double-login mode).
#
# Secrets required in sops (see machines/th0r/nix/sops.nix):
#   - authelia-jwt-secret
#   - authelia-session-secret
#   - authelia-storage-encryption-key
#   - authelia-users (YAML file with user definitions)
{
  config,
  pkgs,
  lib,
  ...
}:
let
  autheliaPort = 9091;
in
{
  services.authelia.instances.main = {
    enable = true;

    secrets = {
      jwtSecretFile = config.sops.secrets."authelia-jwt-secret".path;
      sessionSecretFile = config.sops.secrets."authelia-session-secret".path;
      storageEncryptionKeyFile = config.sops.secrets."authelia-storage-encryption-key".path;
    };

    settings = {
      theme = "dark";

      server = {
        address = "tcp://127.0.0.1:${toString autheliaPort}/authelia";
        endpoints = {
          authz = {
            forward-auth = {
              implementation = "ForwardAuth";
            };
          };
        };
      };

      log = {
        level = "info";
        format = "text";
      };

      # Authentication backend - file-based users
      authentication_backend = {
        file = {
          path = config.sops.secrets."authelia-users".path;
          watch = false; # Can't watch sops-managed /run/secrets directory
          password = {
            algorithm = "argon2";
            argon2 = {
              variant = "argon2id";
              iterations = 3;
              memory = 65536;
              parallelism = 4;
              key_length = 32;
              salt_length = 16;
            };
          };
        };
      };

      # Session configuration
      session = {
        name = "authelia_session";
        expiration = "1h";
        inactivity = "5m";
        remember_me = "1M";
        cookies = [
          {
            domain = "tail13fdb.ts.net";
            authelia_url = "https://th0r.tail13fdb.ts.net/authelia";
            default_redirection_url = "https://th0r.tail13fdb.ts.net";
          }
        ];
      };

      # Storage - SQLite for simplicity
      storage = {
        local = {
          path = "/var/lib/authelia-main/db.sqlite3";
        };
      };

      # TOTP 2FA configuration
      totp = {
        disable = false;
        issuer = "th0r.tail13fdb.ts.net";
        algorithm = "sha1";
        digits = 6;
        period = 30;
        skew = 1;
      };

      # Notification - filesystem for now (check /var/lib/authelia-main/notifications.txt for 2FA setup links)
      # TODO: Configure SMTP for email notifications
      notifier = {
        disable_startup_check = false;
        filesystem = {
          filename = "/var/lib/authelia-main/notifications.txt";
        };
      };

      # Access control policies
      access_control = {
        default_policy = "deny";

        rules = [
          # Authelia itself must be accessible
          {
            domain = "th0r.tail13fdb.ts.net";
            resources = [ "^/authelia.*" ];
            policy = "bypass";
          }

          # Landing page - public
          {
            domain = "th0r.tail13fdb.ts.net";
            resources = [ "^/$" "^/home.*" ];
            policy = "bypass";
          }

          # Jellyseerr API - bypass for app integrations
          {
            domain = "th0r.tail13fdb.ts.net";
            resources = [ "^/api/v1.*" ];
            policy = "bypass";
          }

          # Media services - require one factor
          {
            domain = "th0r.tail13fdb.ts.net";
            resources = [
              "^/media.*" # Jellyfin
            ];
            policy = "one_factor";
          }

          # Home Assistant - require one factor
          {
            domain = "th0r.tail13fdb.ts.net";
            resources = [
              "^/ha.*"
              "^/static.*"
              "^/frontend_latest.*"
              "^/auth.*"
              "^/api.*"
            ];
            policy = "one_factor";
          }

          # Everything else (Jellyseerr at root) - one factor
          {
            domain = "th0r.tail13fdb.ts.net";
            policy = "one_factor";
          }
        ];
      };
    };
  };

  # Ensure state directory exists
  systemd.services."authelia-main".serviceConfig = {
    StateDirectory = "authelia-main";
  };
}
