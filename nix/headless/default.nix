# Main modules import for headless nix configuration
#
# Everything shared with the desktop path lives in ../common - time zone,
# locale, stateVersion, bluetooth, the security overlay, and the base
# nix.settings (flakes, sandbox, trusted-users). Only headless-specific
# modules and profile-specific nix settings belong here.
{
  config,
  lib,
  ...
}: {
  imports = [
    ../common
    ./packages.nix
    ./services.nix
    ./environment.nix
    ../applications/nixvim
  ];

  nix.settings = lib.mkMerge [
    (
      lib.mkIf (config.systemSettings.profile == "work")
      {
        # So we can use our local cache
        #always-allow-substitutes = true;
        substituters = [
          "https://nse-services.ci.dec.iotrap.com:5443/nse_ep?priority=30"
          "https://cache.nixos.org?priority=50"
        ];
        trusted-public-keys = [
          "nse_ep:WFCT6O/qy/ZOTidajT3vk56do0GrCeYRl5tCWBvSC7M="
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        ];
        connect-timeout = 5;
        fallback = true;
      }
    )
  ];
}
