{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  lowfi = pkgs.callPackage ../../../derivations/lowfi/lowfi.nix {};
  screen_recorder = pkgs.callPackage ../../../derivations/screen_record.nix {};
  flamelens = pkgs.callPackage ../../../derivations/flamelens {};
  mov-cli = pkgs.callPackage ../../../derivations/mov-cli {};
  yt-dlp = pkgs.callPackage ../../../derivations/mov-cli/packages/yt-dlp.nix {};
  basalt = pkgs.callPackage ../../../derivations/basalt {};
  #himalaya = pkgs.callPackage ../../../derivations/himalaya/himalaya.nix {};
in {
  # If something has been delared with .enable and points to pkgs or homemanager's
  # pkgs we do not need to add it here
  # Here we only do the basic global packages and load up module declerations
  nixpkgs.config = {
    allowUnfree = true;
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
      wttrbar # Weather
      fq
      jq
      yq

      # Flasher tools
      rpi-imager # For flashing images
      # User-friendly, lightweight TUI for disk imaging
      # https://github.com/ifd3f/caligula
      caligula

      # Media players
      # https://github.com/mpv-player/mpv
      mpv
      # https://github.com/videolan/vlc
      vlc
      # https://github.com/FFmpeg/FFmpeg
      ffmpeg-full

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
      # https://github.com/samuela/remod?tab=readme-ov-file
      remod

      # Cursors
      inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default

      # Wallpaper
      waypaper
      waytrogen
      hyprpaper
      inputs.swww.packages.${system}.swww

      # Clipboard stuff
      wl-clipboard
      wl-clip-persist

      # Screenshot stuff
      slurp
      grim
      swappy
      grimblast

      # WMs and stuff
      xwayland

      # XDG Stuff
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
      xdg-utils

      # Sound support
      pavucontrol
      pulseaudio
      pamixer

      # Support for multimedia routing and pipeline processing
      pipewire
      wireplumber

      # For faster XML scraping
      libxml2

      # Looks good not sure how it works, I basically made equivelant
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

      # Some interesing terminal tools from -> https://terminaltrove.com/list/
      # https://asciinema.org/
      asciinema
      # https://github.com/nitefood/asn?tab=readme-ov-file#usage
      asn
      # https://github.com/erikjuhani/basalt
      basalt
      # https://github.com/mixn/carbon-now-cli
      # carbon-now-cli
      # https://github.com/xgi/castero
      castero
      # https://github.com/bensadeh/circumflex
      circumflex
      # https://github.com/AlDanial/cloc
      cloc
      # https://github.com/nik-rev/countryfetch
      countryfetch
      # https://github.com/Dr-Noob/cpufetch?tab=readme-ov-file#8-cpufetch-for-gpus-gpufetch
      cpufetch
      # https://github.com/tuna-f1sh/cyme
      cyme
    ]
    ++ lib.optionals (config.systemSettings.profile == "personal" || config.systemSettings.profile == "gaming") [
      # Desktop apps for my personal and gaming use
      # (discord.override {
      # withOpenASAR = true; # can do this here too
      # withVencord = true;
      # })

      # To read manga
      inputs.manga-tui.packages.${system}.manga-tui

      # To watch anime
      ani-cli

      # TUI Lowfi player
      # DOCS -> https://github.com/talwat/lowfi
      lowfi

      # To watch general content
      mov-cli

      # To watch movies
      inputs.lobster.packages.${system}.lobster

      # Embedded coding, see arduino-ide too
      arduino-ide
      adafruit-nrfutil

      # For 3D printing/designing
      orca-slicer
      kicad
      freecad-wayland
      openscad-unstable

      # For the logic analyzer
      pulseview

      # Minimal client for mpd
      mpc

      # To manually download yt videos
      yt-dlp

      # Rice flexing
      # https://github.com/abishekvashok/cmatrix
      cmatrix
      # https://github.com/da-luce/astroterm
      astroterm
      # https://github.com/karlstav/cava
      cava
      # https://gitlab.com/jallbrit/cbonsai
      # https://www.reddit.com/r/unixporn/comments/axedr4/oc_watch_a_bonsai_tree_grow_in_your_terminal/
      cbonsai
      # https://github.com/lhvy/pipes-rs
      pipes-rs
    ]
    ++ lib.optionals (config.systemSettings.profile == "personal") [
      # Only for personal use
      openvpn
    ]
    ++ lib.optionals (config.systemSettings.profile == "gaming") [
      # CLI program and API to automate the installation and update of GloriousEggroll's Proton-GE.
      # DOCS Check more on mangohub -> https://github.com/flightlessmango/MangoHud
      mangohud

      # https://heroicgameslauncher.com/
      heroic

      # https://mynixos.com/nixpkgs/package/wine-wayland
      wine-wayland
    ]
    ++ lib.optionals (config.systemSettings.profile == "work") [
      # Only for professional life
      openvpn

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
      bcal # https://github.com/jarun/bcal

      # Some performance analysis tools
      flamelens
      xan
      inferno
      # This should help me get some symbols
      # https://github.com/orhun/binsider
      binsider

      # Manage containers
      docker-client
      arion
      dive # https://github.com/wagoodman/dive
      ctop # https://github.com/bcicen/ctop
      ducker # https://github.com/robertpsoane/ducker

      # Manage secrets
      vault
      sops

      # For debugging C and things
      gdb
      # https://cgdb.github.io/docs/cgdb-split.html
      cgdb
    ];
}
