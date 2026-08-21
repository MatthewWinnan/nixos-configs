# Settings shared by every NixOS host, desktop and headless alike.
#
# This exists because nix/default.nix and nix/headless/default.nix were
# near-copies of each other and kept drifting: the security overlay landed in
# one and not the other (leaving the internet-facing hosts without CVE bumps),
# and trusted-users was granted on the desktop path but not the headless one
# (breaking non-root deploys). Anything true for all hosts belongs here so
# there is only one place to change it.
#
# Profile-specific extras - substituters, ssl-cert-file, http-connections -
# stay in the importing module, since those genuinely differ.
{
  config,
  lib,
  ...
}: {
  imports = [
    ../networking
    ../user
    # CVE bumps from nixpkgs-unstable.
    ../applications/packages/security-overlay.nix
    # attic watch-store. Lives here rather than under nix/services so the
    # headless hosts get it too - nix/headless imports its own services.nix
    # and would otherwise miss it.
    ../services/attic_store.nix
  ];

  # Set your time zone.
  time.timeZone = config.systemSettings.timezone;

  # Select internationalisation properties.
  i18n.defaultLocale = config.systemSettings.locale;

  # Base nix settings for every profile.
  nix.settings = lib.mkMerge [
    {
      # Enable Flakes
      experimental-features = ["nix-command" "flakes"];
      # For an explanation of how this works check -> https://mynixos.com/nixpkgs/option/nix.settings.sandbox
      sandbox = lib.mkDefault "relaxed";
      # Required for `nixos-rebuild --target-host <user>@<host>`: an untrusted
      # user cannot push unsigned store paths, which fails nix-copy-closure with
      # "lacks a signature by a trusted key". Root SSH is key-only and only the
      # primary user has a declared key, so deploys run as that user.
      trusted-users = [config.userSettings.username "root"];
    }
    (
      # Self-hosted attic cache on th0r (nix/services/atticd.nix).
      #
      # Gated to non-work profiles to match nix/services/tailscale.nix: th0r is
      # only reachable over the tailnet, and work machines are not on it. A work
      # host would just stall on an unreachable substituter.
      #
      # priority=10 puts it ahead of cache.nixos.org (50) and the fastly mirror
      # (30) - it is on the LAN/tailnet and should be asked first. Misses fall
      # through to the public caches.
      lib.mkIf (config.systemSettings.profile != "work")
      {
        substituters = ["http://th0r:8081/nixos?priority=10"];
        trusted-public-keys = ["nixos:oaVh/lpdWKJW2M8u+UxCCZaBcTqkmDu3zuEJWhZxGbg="];
      }
    )
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  # For bluetooth support
  # TODO I should ideally move this to hardware or something
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on bootboot
}
