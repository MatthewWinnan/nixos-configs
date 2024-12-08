{config, pkgs, lib, inputs, ...}:

let
  lowfi = pkgs.callPackage ../../derivations/lowfi/lowfi.nix {};
  screen_recorder = pkgs.callPackage ../../derivations/screen_record.nix {};
  #himalaya = pkgs.callPackage ../../derivations/himalaya/himalaya.nix {};
in
{
  # If something has been delared with .enable and points to pkgs or homemanager's
  # pkgs we do not need to add it here
  # Here we only do the basic global packages and load up module declerations
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = ["python-2.7.18.8" "electron-25.9.0"];
  };

  environment.systemPackages = with pkgs; [
    # Default desktop apps
    chromium
    gparted
    obsidian
    udiskie

    # Default coding stuff (I want to progressively strip these away)
    # pyserial is needed for my arduino-ide
    gnumake
    gcc
    python
    (python3.withPackages (ps: with ps; [ requests pyserial]))

    # Default CLI tools for everyone
    wget
    htop
    openssl
    nix-output-monitor
    nvd
    wf-recorder # Else we do not have access to it on CLI
    mpv # To view the recordings

    # This tool generates derivations for me from git projects
    # DOCS -> https://github.com/nix-community/nix-init?tab=readme-ov-file
    nix-init

    # TUI/GUI utils
    dmenu
    xdragon
    pistol
    hyprcursor
    # https://github.com/darkhz/bluetuith
    bluetuith
    blueman

    # Cursors
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default

    # Wallpaper
    waypaper
    inputs.swww.packages.${system}.swww

    # Wayland stuff
    xwayland

    # Screenshot stuff
    cliphist
    wl-clipboard
    wl-clip-persist
    slurp
    grim
    swappy

    # WMs and stuff
    xdg-desktop-portal-hyprland
    wttrbar # Weather

    # Sound support
    pavucontrol
    pipewire
    pulseaudio
    pamixer

    # Screenshotting
    grimblast

    # Looks good not sure how it works, I baically made equivelant
    # flameshot

    # Custom recorder
    screen_recorder

    # CLI to manage emails, based on email-lib
    #himalaya
    # Seems things are missing by just building myself, use this https://github.com/pimalaya/himalaya/issues/468
    # inputs.himalaya.packages.${system}.himalaya
    # Instead I will for now use it from home manager hopefully
    # FOr now I am gettin the issue: Unable to parse authentication response, I will wait for stable NIX
    #himalaya

  ] ++ lib.optionals (config.systemSettings.profile == "personal" || config.systemSettings.profile == "gaming") [
      # Desktop apps for my personal and gaming use
      discord

      # To read manga
      inputs.manga-tui.packages.${system}.manga-tui

      # To watch anime
      ani-cli

  ] ++ lib.optionals (config.systemSettings.profile == "personal")[
      # Only for personal use
      arduino-ide
      openvpn
      skypeforlinux

      # For 3D printing/designing
      orca-slicer
      kicad
      freecad-wayland

      # Embedded coding, see arduino-ide too
      adafruit-nrfutil
      rpi-imager

      # TUI Lowfi player
      # DOCS -> https://github.com/talwat/lowfi
      lowfi

  ] ++ lib.optionals (config.systemSettings.profile == "work")[

      # Only for professional life
      openvpn
      skypeforlinux

      # I still need to flash
      rpi-imager

      # We use gerrit
      git-review

      # I need telnet and the like for networking
      inetutils

      # I need packet analyzers TODO check for NIX options
      wireshark
      tshark
      termshark

      # For some nice calculator functions
      bitwise # https://github.com/mellowcandle/bitwise
      programmer-calculator # https://github.com/alt-romes/programmer-calculator
      qalculate-gtk
    ];

}
