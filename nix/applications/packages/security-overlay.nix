# Security overlay — pulls newer package versions from nixpkgs-unstable
# to address known CVEs not yet patched in nixos-26.05.
#
# Generated: 2026-08-17
# Audit source: logs/audit/1786969896_fafn1r_vulns.csv
#
# ┌─────────────────────────────────────────────────────────────────────────────┐
# │ ACTIVE OVERLAYS (minimal rebuild cost)                                      │
# ├──────────────┬───────────┬───────────┬──────────────────────────────────────┤
# │ Package      │ 26.05     │ unstable  │ CVEs addressed                       │
# ├──────────────┼───────────┼───────────┼──────────────────────────────────────┤
# │ fzf          │ 0.72.0    │ 0.74.2    │ CVE-2026-53433 (7.5), 53432 (7.5)   │
# │ podman       │ 5.8.2     │ 5.8.4     │ CVE-2022-2989 (7.1), 2023-0778(6.8) │
# └──────────────┴───────────┴───────────┴──────────────────────────────────────┘
#
# ┌─────────────────────────────────────────────────────────────────────────────┐
# │ DEFERRED — require full system rebuild (nixpkgs bump or long build)         │
# ├──────────────┬───────────┬───────────┬──────────────────────────────────────┤
# │ Package      │ 26.05     │ unstable  │ CVEs / Notes                         │
# ├──────────────┼───────────┼───────────┼──────────────────────────────────────┤
# │ sqlite       │ 3.51.2    │ 3.53.3    │ CVE-2026-11824 (8.5), 11822 (8.5)   │
# │              │           │           │ 27+ store referrers — rebuilds FF etc │
# │ libssh2      │ 1.11.1    │ 1.11.1+4p │ CVE-2026-7598 (9.1), 66033 (8.7)…  │
# │              │           │           │ Chains through curl → mass rebuild    │
# │ libssh       │ 0.12.1    │ 0.12.2    │ CVE-2026-59851 (8.8), 59850 (7.5)…  │
# │              │           │           │ 7 referrers, may chain               │
# │ giflib       │ 5.2.2     │ 6.1.3     │ CVE-2026-26740 (7.5), 23868 (7.0)   │
# │              │           │           │ 9 referrers in image pipeline        │
# │ gdk-pixbuf   │ 2.44.6    │ 2.44.7    │ CVE-2026-5201 (7.5)                  │
# │              │           │           │ 81 referrers — rebuilds all GTK apps  │
# └──────────────┴───────────┴───────────┴──────────────────────────────────────┘
#
# RESOLUTION OPTIONS for deferred packages:
#   1. Full nixpkgs bump to unstable (config risk, module compat)
#   2. Remote build on office machine (`nixos-rebuild --target-host`)
#   3. Wait for 26.05 security backports (NixOS security team)
#   4. Accept risk with documented whitelist (if threat model allows)
#
# ┌─────────────────────────────────────────────────────────────────────────────┐
# │ NOT OVERLAID — same version on both branches, awaiting upstream fix         │
# ├──────────────┬───────────┬─────────────────────────────────────────────────┤
# │ Package      │ Version   │ Exploitability assessment                        │
# ├──────────────┼───────────┼─────────────────────────────────────────────────┤
# │ glibc        │ 2.42      │ Low practical risk on desktop. 3 resolv CVEs     │
# │              │           │ already patched. Remaining require impractical   │
# │              │           │ attacker control (format widths, PTRDIFF_MAX     │
# │              │           │ alignment). No upstream 2.43 exists.             │
# │              │           │                                                   │
# │ gnutls       │ 3.8.13    │ Moderate. Server-only CVEs (RSA-PSK, DTLS)      │
# │              │           │ whitelisted. Client-relevant cert validation     │
# │              │           │ bypass (CVE-2026-42013, 8.2) remains — requires  │
# │              │           │ active MITM. 3.8.13 IS the latest upstream.      │
# │              │           │                                                   │
# │ openssh      │ 10.4p1    │ Low. Latest upstream. Ancient CVEs whitelisted.  │
# │              │           │ CVE-2026-3497 (GSSAPI info disclosure) remains   │
# │              │           │ — mitigated by key-only auth config.             │
# │              │           │                                                   │
# │ openssl      │ 3.6.3     │ Low on desktop. Server-side DoS whitelisted.     │
# │              │           │ 3.6.3 is the latest upstream.                    │
# └──────────────┴───────────┴─────────────────────────────────────────────────┘
#
{inputs, pkgs, ...}: let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in {
  nixpkgs.overlays = [
    (_final: _prev: {
      # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      # ACTIVE — leaf packages with minimal rebuild impact
      # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

      # fzf 0.72.0 → 0.74.2
      # Fixes CVE-2026-53433 and CVE-2026-53432 (both 7.5)
      # Rebuild: ~6 packages (shell integrations, mov-cli)
      inherit (unstable) fzf;

      # podman 5.8.2 → 5.8.4
      # Fixes CVE-2022-2989 (7.1 — container escape), CVE-2023-0778 (6.8)
      # Rebuild: podman only (0 store referrers, isolated runtime)
      inherit (unstable) podman;

      # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      # DEFERRED — uncomment when doing a full rebuild (office, overnight, CI)
      # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

      # sqlite 3.51.2 → 3.53.3
      # Fixes CVE-2026-11824 and CVE-2026-11822 (both 8.5 — type confusion)
      # Rebuild impact: ~27 packages (Firefox, Authelia, many apps)
      # sqlite = unstable.sqlite;

      # libssh2 1.11.1 (7 patches) → 1.11.1 (11 patches)
      # Fixes CVE-2026-7598 (9.1), CVE-2026-66033 (8.7), CVE-2026-58051 (8.3)
      # Rebuild impact: chains through curl → mass rebuild
      # libssh2 = unstable.libssh2;

      # libssh 0.12.1 → 0.12.2
      # Fixes CVE-2026-59851 (8.8 — pre-auth RCE), CVE-2026-59850 (7.5)
      # Rebuild impact: 7+ packages, may chain
      # libssh = unstable.libssh;

      # giflib 5.2.2 → 6.1.3
      # Fixes CVE-2026-26740 (7.5), CVE-2026-23868 (7.0), CVE-2024-45993 (6.5)
      # Rebuild impact: ~9 packages in image pipeline
      # giflib = unstable.giflib;

      # gdk-pixbuf 2.44.6 → 2.44.7
      # Fixes CVE-2026-5201 (7.5 — DoS via crafted image)
      # Rebuild impact: 81 packages — ALL GTK/GNOME apps
      # gdk-pixbuf = unstable.gdk-pixbuf;
    })
  ];
}
