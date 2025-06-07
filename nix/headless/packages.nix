{pkgs, ...}: {
  # If something has been delared with .enable and points to pkgs or homemanager's
  # pkgs we do not need to add it here
  # Here we only do the basic global packages and load up module declerations
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    # Default coding stuff (I want to progressively strip these away)
    # pyserial is needed for my arduino-ide
    gnumake
    gcc
    (python3.withPackages (ps:
      with ps; [
        requests
        pyserial
      ]))

    # Default CLI tools for everyone
    wget
    htop
    openssl
    nix-output-monitor
    nvd
    just
    mpv # To view the recordings

    # For caching setup
    attic-client
    attic-server

    # This tool generates derivations for me from git projects
    # DOCS -> https://github.com/nix-community/nix-init?tab=readme-ov-file
    nix-init

    # TUI/GUI utils
    pistol
    # https://github.com/darkhz/bluetuith
    bluetuith

    # XDG management?
    xdg-utils
  ];
}
