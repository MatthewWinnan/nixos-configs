# Main modules import
#
# Everything shared with the headless path lives in ./common - time zone,
# locale, stateVersion, bluetooth, the security overlay, and the base
# nix.settings (flakes, sandbox, trusted-users). Only desktop-specific
# modules and profile-specific nix settings belong here.
{
  config,
  lib,
  ...
}: {
  imports = [
    ./common
    ./applications
    ./services
    ./security
    ./environment
  ];

  # Trust nse-services self-signed cert for nix cache + ETO resign CA
  # Only needed on office network where these services are reachable
  security.pki.certificateFiles = lib.mkIf (config.systemSettings.profile == "work" && config.deviceSettings.location == "work") [
    ../certs/nse-services.crt
    ../certs/eto-resign-ca.pem
    ../certs/gitlab.pem
  ];

  # crates.io CDN 403s requests without a recognized User-Agent (work proxy rewrites)
  systemd.services.nix-daemon.environment.NIX_CURL_FLAGS = lib.mkIf (config.systemSettings.profile == "work" && config.deviceSettings.location == "work") "--user-agent nix";

  nix.settings = lib.mkMerge [
    (
      lib.mkIf (config.systemSettings.profile == "work")
      {
        # Ensure Nix fixed-output derivation fetches (e.g. fetchgit) trust our
        # proxy's re-signed certs (ETO resign CA). Without this, sources hosted
        # on sites like Codeberg fail SSL verification inside the sandbox.
        ssl-cert-file = "/etc/ssl/certs/ca-certificates.crt";

        connect-timeout = 5;
        fallback = true;
      }
    )
    (
      # nse-services cache only available on office network
      lib.mkIf (config.systemSettings.profile == "work" && config.deviceSettings.location == "work")
      {
        # Use nse_ep cache (priority 30) with cache.nixos.org as fallback
        # NOTE: This URL is an internal FQDN (not resolvable externally).
        # Accepted exposure in public repo — no secrets, just topology hint.
        substituters = [
          "https://nse-services.ci.dec.iotrap.com:5443/nse_ep?priority=30"
          "https://cache.nixos.org?priority=50"
        ];
        trusted-public-keys = [
          "nse_ep:WFCT6O/qy/ZOTidajT3vk56do0GrCeYRl5tCWBvSC7M="
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        ];
      }
    )
    (
      # At home, only use cache.nixos.org
      lib.mkIf (config.systemSettings.profile == "work" && config.deviceSettings.location == "home")
      {
        substituters = [
          "https://cache.nixos.org?priority=50"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        ];
      }
    )
    (
      lib.mkIf (config.systemSettings.profile == "gaming")
      {
        http-connections = 50;
        substituters = [
          "https://aseipp-nix-cache.global.ssl.fastly.net?priority=30"
          "https://cache.nixos.org?priority=50"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        ];
      }
    )
  ];
}
