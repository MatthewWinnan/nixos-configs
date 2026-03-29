{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  # Import unstable packages for specific packages
  pkgs-unstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };

  # Override stremio to fix build issue (PR #503035)
  # The cargo deps directory structure changed, adding */ after $cargoDepsCopy
  stremio-fixed = pkgs-unstable.stremio-linux-shell.overrideAttrs (oldAttrs: {
    postPatch =
      lib.replaceStrings
        [
          "$cargoDepsCopy/libappindicator-sys-*"
          "$cargoDepsCopy/xkbcommon-dl-*"
        ]
        [
          "$cargoDepsCopy/*/libappindicator-sys-*"
          "$cargoDepsCopy/*/xkbcommon-dl-*"
        ]
        oldAttrs.postPatch;
  });

  lowfi = pkgs.callPackage ../../../derivations/lowfi/lowfi.nix { };
  screen_recorder = pkgs.callPackage ../../../derivations/screen_record.nix { };
  flamelens = pkgs.callPackage ../../../derivations/flamelens { };
  kiro-cli = pkgs.callPackage ../../../derivations/kiro-cli { };

  # NB broken failing to install fix
  # mov-cli = pkgs.callPackage ../../../derivations/mov-cli {};

  yt-dlp = pkgs.callPackage ../../../derivations/mov-cli/packages/yt-dlp.nix { };
  ducker = pkgs.callPackage ../../../derivations/ducker { };
  kicad-wrapped = pkgs.callPackage ../../../derivations/kicad-wrapped { };
  orca-wrapped = pkgs.callPackage ../../../derivations/orca-wrapped { };
  freecad-wrapped = pkgs.callPackage ../../../derivations/freecad-wrapped { };
in
{
  # If something has been delared with .enable and points to pkgs or homemanager's
  # pkgs we do not need to add it here
  # Here we only do the basic global packages and load up module declerations
  nixpkgs.config = {
    allowUnfree = true;
    # NB added since arduino still uses this but not security vul technically
    permittedInsecurePackages = [
      "python3.13-ecdsa-0.19.1"
    ];
  };

  # Override libreoffice to bypass Stylix GTK theming
  nixpkgs.overlays = [
    (final: prev: {
      libreoffice = prev.libreoffice.overrideAttrs (old: {
        nativeBuildInputs = (old.nativeBuildInputs or []) ++ [ prev.makeWrapper ];
        postFixup = (old.postFixup or "") + ''
          for bin in $out/bin/*; do
            wrapProgram "$bin" --set GTK_THEME "Adwaita"
          done
        '';
      });
    })
  ];

  environment.systemPackages =
    with pkgs;
    [
      # Default desktop apps
      gparted # Disk partitioning
      libreoffice # Office suite
      obsidian # Note-taking
      udiskie # Automounter

      # Default coding stuff (I want to progressively strip these away)
      # pyserial is needed for my arduino-ide
      gcc
      gnumake
      (python3.withPackages (
        ps: with ps; [
          pyserial
          requests
        ]
      ))
      uv

      # Default CLI tools for everyone
      fq # Binary data querying
      htop # Process monitoring
      jq # JSON querying
      just # Task runner
      nix-output-monitor # Nix build output
      nvd # Nix version diff
      openssl # Cryptography toolkit
      unzip # Archive extraction
      wf-recorder # Screen recording (CLI access)
      wget # File downloading
      wttrbar # Weather
      yq # YAML querying

      # Flasher tools
      # https://github.com/ifd3f/caligula
      caligula # TUI disk imaging
      rpi-imager # Raspberry Pi imager

      # Media players
      # https://github.com/FFmpeg/FFmpeg
      ffmpeg-full # Media processing
      # https://github.com/mpv-player/mpv
      mpv # Minimal video player
      # https://github.com/videolan/vlc
      vlc # Full-featured media player

      # For caching setup
      attic-client
      attic-server

      # This tool generates derivations for me from git projects
      # DOCS -> https://github.com/nix-community/nix-init?tab=readme-ov-file
      nix-init

      # TUI/GUI utils
      # https://github.com/darkhz/bluetuith
      bluetuith # Bluetooth TUI
      blueman # Bluetooth GUI
      dmenu # Application launcher
      dragon-drop # Drag-and-drop utility
      hyprcursor # Cursor theme
      pistol # File previewer
      # https://github.com/samuela/remod?tab=readme-ov-file
      remod # File permission editor
      # https://github.com/rvaiya/warpd?tab=readme-ov-file#wayland
      warpd # Keyboard-driven mouse

      # Cursors
      inputs.rose-pine-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default

      # Wallpaper
      hyprpaper
      inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
      waypaper
      waytrogen

      # Clipboard stuff
      wl-clip-persist
      wl-clipboard

      # Screenshot stuff
      grim # Screenshot capture
      grimblast # Screenshot wrapper
      slurp # Region selection
      swappy # Screenshot editor

      # Custom recorder
      screen_recorder

      # WMs and stuff
      xwayland

      # XDG Stuff
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      xdg-utils

      # Sound support
      pamixer # PulseAudio CLI mixer
      pavucontrol # PulseAudio GUI
      pulseaudio # Audio server

      # Support for multimedia routing and pipeline processing
      pipewire
      wireplumber

      # For faster XML scraping
      libxml2

      # Some interesting terminal tools from -> https://terminaltrove.com/list/
      # https://asciinema.org/
      asciinema # Terminal recording
      # https://github.com/nitefood/asn?tab=readme-ov-file#usage
      asn # ASN lookup
      # https://github.com/xgi/castero
      # castero # Podcast client
      # https://github.com/bensadeh/circumflex
      circumflex # Hacker News reader
      # https://github.com/AlDanial/cloc
      cloc # Code line counter
      # https://github.com/nik-rev/countryfetch
      countryfetch # System info (country theme)
      # https://github.com/Dr-Noob/cpufetch?tab=readme-ov-file#8-cpufetch-for-gpus-gpufetch
      cpufetch # CPU info display
      # https://github.com/tuna-f1sh/cyme
      cyme # USB device lister

      # Formatter
      inputs.alejandra.defaultPackage.${pkgs.stdenv.hostPlatform.system}
    ]
    ++
      lib.optionals
        (config.systemSettings.profile == "personal" || config.systemSettings.profile == "gaming")
        [
          # Media streaming/downloading
          ani-cli # Anime streaming
          # inputs.manga-tui.packages.${pkgs.stdenv.hostPlatform.system}.manga-tui # Manga reader (NB will not build)
          inputs.lobster.packages.${pkgs.stdenv.hostPlatform.system}.lobster # Movie streaming
          mov-cli # General content streaming
          yt-dlp # Video downloader
          stremio-fixed # Using unstable version with build fix

          # Music/audio
          # https://github.com/talwat/lowfi
          lowfi # TUI Lowfi player
          mpc # Minimal mpd client

          # Embedded development (see arduino-ide too)
          # NB: These still use "python3.13-ecdsa-0.19.1"
          adafruit-nrfutil
          arduino-ide

          # 3D printing/designing - CAD
          freecad-wayland
          freecad-wrapped
          openscad-unstable

          # 3D printing/designing - Slicer
          orca-slicer
          orca-wrapped

          # 3D printing/designing - PCB/Electronics
          kicad
          kicad-wrapped
          pulseview # Logic analyzer

          # Development tools
          nodejs # includes npx (for MCP servers)

          # Streaming/social
          # https://github.com/Xithrius/twitch-tui
          twitch-cli # Twitch chat CLI

          # Rice flexing - visualizers
          # https://github.com/karlstav/cava
          cava # Audio visualizer
          # Rice flexing - animations
          # https://github.com/da-luce/astroterm
          astroterm # Star map
          # https://gitlab.com/jallbrit/cbonsai
          # https://www.reddit.com/r/unixporn/comments/axedr4/oc_watch_a_bonsai_tree_grow_in_your_terminal/
          cbonsai # Bonsai tree
          # https://github.com/abishekvashok/cmatrix
          cmatrix # Matrix rain
          # https://github.com/lhvy/pipes-rs
          pipes-rs # Pipe screensaver
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
      # programmer-calculator # https://github.com/alt-romes/programmer-calculator
      qalculate-gtk
      # bcal # https://github.com/jarun/bcal

      # Some performance analysis tools
      flamelens
      xan
      xlsx2csv
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

      # For agentic workflows
      kiro-cli
    ];
}
