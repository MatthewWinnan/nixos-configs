{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  lowfi = pkgs.callPackage ../../derivations/lowfi/lowfi.nix {};
  screen_recorder = pkgs.callPackage ../../derivations/screen_record.nix {};
  flamelens = pkgs.callPackage ../../derivations/flamelens {};
  #himalaya = pkgs.callPackage ../../derivations/himalaya/himalaya.nix {};
in {
  # If something has been delared with .enable and points to pkgs or homemanager's
  # pkgs we do not need to add it here
  # Here we only do the basic global packages and load up module declerations
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = ["python-2.7.18.8" "electron-25.9.0"];
  };

  environment.systemPackages = with pkgs;
    [
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
      wf-recorder # Else we do not have access to it on CLI
      mpv # To view the recordings

      # For caching setup
      attic-client
      attic-server

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
      # https://github.com/rvaiya/warpd?tab=readme-ov-file#wayland
      #warpd

      # Cursors
      inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default

      # Wallpaper
      waypaper
      hyprpaper
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
      xdg-desktop-portal-gnome
      wttrbar # Weather

      # Sound support
      pavucontrol
      pulseaudio
      pamixer

      # Support for multimedia routing and pipeline processing
      pipewire
      wireplumber

      # Screenshotting
      grimblast

      # To watch general content
      # Getting build issues with 25.05
      #mov-cli

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
      himalaya
    ]
    ++ lib.optionals (config.systemSettings.profile == "personal" || config.systemSettings.profile == "gaming") [
      # Desktop apps for my personal and gaming use
      discord

      # To read manga
      inputs.manga-tui.packages.${system}.manga-tui

      # To watch anime
      ani-cli

      # TUI Lowfi player
      # DOCS -> https://github.com/talwat/lowfi
      lowfi

      # Embedded coding, see arduino-ide too
      arduino-ide
      adafruit-nrfutil
      rpi-imager

      # For 3D printing/designing
      orca-slicer
      kicad
      freecad-wayland
      openscad-unstable

      # For the logic analyzer
      pulseview
    ]
    ++ lib.optionals (config.systemSettings.profile == "personal") [
      # Only for personal use
      openvpn
      skypeforlinux
    ]
    ++ lib.optionals (config.systemSettings.profile == "gaming") [
      # CLI program and API to automate the installation and update of GloriousEggroll's Proton-GE.
      # DOCS Check more on mangohub -> https://github.com/flightlessmango/MangoHud
      mangohud
    ]
    ++ lib.optionals (config.systemSettings.profile == "work") [
      # Only for professional life
      openvpn
      skypeforlinux

      # I still need to flash
      rpi-imager

      # We use gerrit
      git-review

      # I am also moving to Fossil
      fossil

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

      # Some performance analysis tools
      flamelens
      xan
      inferno

      # Manage containers
      docker-client
      arion

      # Manage secrets
      vault
      sops
    ];
}
