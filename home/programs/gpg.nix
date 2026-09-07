# GnuPG DOCS -> https://nix-community.github.io/home-manager/options.xhtml#opt-programs.gpg.enable
# gpg-agent DOCS -> https://nix-community.github.io/home-manager/options.xhtml#opt-services.gpg-agent.enable
{
  pkgs,
  config,
  ...
}: {
  programs.gpg = {
    enable = true;

    # Sensible hardening defaults for key/cipher preferences and output.
    settings = {
      # Show long key IDs and fingerprints — short IDs are collision-prone.
      keyid-format = "0xlong";
      with-fingerprint = true;

      # Prefer strong algorithms when generating/using keys.
      personal-cipher-preferences = "AES256 AES192 AES";
      personal-digest-preferences = "SHA512 SHA384 SHA256";
      personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
      default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";
      cert-digest-algo = "SHA512";
      s2k-digest-algo = "SHA512";
      s2k-cipher-algo = "AES256";
    };
  };

  services.gpg-agent = {
    enable = true;

    # Cache timeouts (seconds). Re-prompt for the passphrase after inactivity.
    defaultCacheTtl = 1800; # 30 min
    maxCacheTtl = 7200; # 2 h

    # Let the agent also serve as the SSH agent for GPG auth subkeys.
    enableSshSupport = true;

    # Shell integrations mirror the pattern used elsewhere in this config.
    enableFishIntegration = config.programs.fish.enable;
    enableZshIntegration = config.programs.zsh.enable;
    enableBashIntegration = config.programs.bash.enable;

    # GUI pinentry — this is a Hyprland/Wayland desktop, so use the GNOME
    # pinentry which works under Wayland. Falls back to curses over SSH.
    pinentry.package = pkgs.pinentry-gnome3;
  };

  # pinentry-gnome3 needs gcr's D-Bus prompter to render outside GNOME
  # (e.g. under Hyprland). Without it the passphrase prompt fails to appear.
  home.packages = [pkgs.gcr];
}
