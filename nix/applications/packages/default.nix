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

  # Custom derivations
  lowfi = pkgs.callPackage ../../../derivations/lowfi/lowfi.nix { };
  screen_recorder = pkgs.callPackage ../../../derivations/screen_record.nix { };
  flamelens = pkgs.callPackage ../../../derivations/flamelens { };
  kiro-cli = pkgs.callPackage ../../../derivations/kiro-cli { };
  yt-dlp = pkgs.callPackage ../../../derivations/mov-cli/packages/yt-dlp.nix { };
  ducker = pkgs.callPackage ../../../derivations/ducker { };
  kicad-wrapped = pkgs.callPackage ../../../derivations/kicad-wrapped { };
  orca-wrapped = pkgs.callPackage ../../../derivations/orca-wrapped { };
  freecad-wrapped = pkgs.callPackage ../../../derivations/freecad-wrapped { };

  # ============================================================================
  # CORE PACKAGES - Essential system tools for all profiles
  # ============================================================================

  cliToolsPackages = with pkgs; [
    fq # Binary data querying
    htop # Process monitoring
    jq # JSON querying
    just # Task runner
    openssl # Cryptography toolkit
    unzip # Archive extraction
    wget # File downloading
    wttrbar # Weather
    yq # YAML querying
    libxml2 # For faster XML scraping
    tcpdump # For packet inspection
  ];

  desktopPackages = with pkgs; [
    gparted # Disk partitioning
    libreoffice # Office suite
    obsidian # Note-taking
    udiskie # Automounter
    pinta # https://www.pinta-project.com/
  ];

  developmentPackages = with pkgs; [
    # pyserial is needed for arduino-ide
    gcc
    gnumake
    (python3.withPackages (
      ps: with ps; [
        pyserial
        requests
      ]
    ))
    uv
  ];

  # ============================================================================
  # MEDIA PACKAGES
  # ============================================================================

  mediaPackages = with pkgs; [
    # https://github.com/FFmpeg/FFmpeg
    ffmpeg-full # Media processing
    # https://github.com/mpv-player/mpv
    mpv # Minimal video player
    # https://github.com/videolan/vlc
    vlc # Full-featured media player
    wf-recorder # Screen recording (CLI access)
    typora # https://typora.io/
    imagemagick # https://github.com/ImageMagick/ImageMagick
  ];

  flasherPackages = with pkgs; [
    # https://github.com/ifd3f/caligula
    caligula # TUI disk imaging
    rpi-imager # Raspberry Pi imager
  ];

  # ============================================================================
  # NIX TOOLING
  # ============================================================================

  nixToolsPackages = with pkgs; [
    nix-output-monitor # Nix build output
    nvd # Nix version diff
    # This tool generates derivations for me from git projects
    # DOCS -> https://github.com/nix-community/nix-init?tab=readme-ov-file
    nix-init
    # Formatter
    inputs.alejandra.defaultPackage.${pkgs.stdenv.hostPlatform.system}
    # For caching setup
    attic-client
    attic-server
  ];

  # ============================================================================
  # TUI/GUI UTILITIES
  # ============================================================================

  tuiGuiPackages = with pkgs; [
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
    # https://github.com/pythops/impala
    impala
    # https://github.com/tsowell/wiremix
    wiremix
    # https://github.com/bootandy/dust
    dust
    # https://github.com/gferraro/voxtype
    pkgs-unstable.voxtype-vulkan # Voice-to-text for Wayland
  ];

  # ============================================================================
  # DESKTOP ENVIRONMENT - Hyprland/Wayland
  # ============================================================================

  cursorPackages = with pkgs; [
    inputs.rose-pine-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  wallpaperPackages = with pkgs; [
    hyprpaper
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    waypaper
    waytrogen
  ];

  clipboardPackages = with pkgs; [
    wl-clip-persist
    wl-clipboard
  ];

  screenshotPackages = with pkgs; [
    grim # Screenshot capture
    grimblast # Screenshot wrapper
    slurp # Region selection
    swappy # Screenshot editor
    screen_recorder # Custom recorder
  ];

  xdgPackages = with pkgs; [
    xwayland
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xdg-utils
  ];

  audioPackages = with pkgs; [
    pamixer # PulseAudio CLI mixer
    pavucontrol # PulseAudio GUI
    pulseaudio # Audio server
    pipewire # Multimedia routing
    wireplumber # Session manager
  ];

  # ============================================================================
  # TERMINAL TOOLS - from https://terminaltrove.com/list/
  # ============================================================================

  terminalToolsPackages = with pkgs; [
    # https://asciinema.org/
    asciinema # Terminal recording
    # https://github.com/nitefood/asn?tab=readme-ov-file#usage
    asn # ASN lookup
    # https://github.com/bensadeh/circumflex
    circumflex # Hacker News reader
    # https://github.com/AlDanial/cloc
    tokei # Code statistics (faster cloc replacement)
    # https://github.com/nik-rev/countryfetch
    countryfetch # System info (country theme)
    # https://github.com/Dr-Noob/cpufetch?tab=readme-ov-file#8-cpufetch-for-gpus-gpufetch
    cpufetch # CPU info display
    # https://github.com/tuna-f1sh/cyme
    cyme # USB device lister
    # https://github.com/dalance/procs
    procs # Prettier ps replacement
    # https://github.com/orf/gping
    gping # Ping with graph
    # https://github.com/rofl0r/ncdu
    ncdu # Interactive disk usage explorer
    # https://github.com/charmbracelet/glow
    glow # Terminal markdown renderer
    # https://github.com/sharkdp/hyperfine
    hyperfine # CLI benchmarking tool
    # https://github.com/denisidoro/navi
    navi # Interactive cheatsheet
    # https://github.com/chmln/sd
    sd # Intuitive sed alternative
    # https://github.com/theryangeary/choose
    choose # Simpler cut alternative
    # https://github.com/mr-karan/doggo
    doggo # Prettier dig alternative
    # https://github.com/ducaale/xh
    xh # Colorized curl alternative
    # https://github.com/fujiapple852/trippy
    trippy # Visual traceroute TUI
    # https://github.com/sharkdp/hexyl
    hexyl # Colorized hex viewer
  ];

  # ============================================================================
  # ROLE-SPECIFIC: Personal + Gaming shared packages
  # ============================================================================

  mediaStreamingPackages = [
    pkgs.ani-cli # Anime streaming
    inputs.lobster.packages.${pkgs.stdenv.hostPlatform.system}.lobster # Movie streaming
    pkgs.mov-cli # General content streaming
    yt-dlp # Video downloader (custom derivation)
    stremio-fixed # Using unstable version with build fix
  ];

  musicPackages = [
    lowfi # TUI Lowfi player (custom derivation)
    pkgs.mpc # Minimal mpd client
    pkgs-unstable.spotatui # TUI Spotify client
  ];

  embeddedDevPackages = with pkgs; [
    # NB: These still use "python3.13-ecdsa-0.19.1"
    adafruit-nrfutil
    arduino-ide
  ];

  cadPackages = [
    pkgs.freecad-wayland
    freecad-wrapped # Custom derivation
    pkgs.openscad-unstable
  ];

  slicerPackages = [
    pkgs.orca-slicer
    orca-wrapped # Custom derivation
  ];

  pcbPackages = [
    pkgs.kicad
    kicad-wrapped # Custom derivation
    pkgs.pulseview # Logic analyzer
  ];

  ricePackages = with pkgs; [
    # Visualizers
    # https://github.com/karlstav/cava
    cava # Audio visualizer
    # Animations
    # https://github.com/da-luce/astroterm
    astroterm # Star map
    # https://gitlab.com/jallbrit/cbonsai
    cbonsai # Bonsai tree
    # https://github.com/abishekvashok/cmatrix
    cmatrix # Matrix rain
    # https://github.com/lhvy/pipes-rs
    pipes-rs # Pipe screensaver
  ];

  personalGamingPackages =
    mediaStreamingPackages
    ++ musicPackages
    ++ embeddedDevPackages
    ++ cadPackages
    ++ slicerPackages
    ++ pcbPackages
    ++ ricePackages
    ++ (with pkgs; [
      nodejs # includes npx (for MCP servers)
      # https://github.com/Xithrius/twitch-tui
      twitch-cli # Twitch chat CLI
      # For secrets
      sops
    ]);

  # ============================================================================
  # ROLE-SPECIFIC: Personal only
  # ============================================================================

  personalOnlyPackages = with pkgs; [
    openvpn
  ];

  # ============================================================================
  # ROLE-SPECIFIC: Gaming only
  # ============================================================================

  gamingOnlyPackages = with pkgs; [
    # CLI program and API to automate the installation and update of GloriousEggroll's Proton-GE.
    # DOCS Check more on mangohub -> https://github.com/flightlessmango/MangoHud
    mangohud
    # https://heroicgameslauncher.com/
    heroic
    # https://mynixos.com/nixpkgs/package/wine-wayland
    wine-wayland
  ];

  # ============================================================================
  # ROLE-SPECIFIC: Work
  # ============================================================================

  vcsPackages = with pkgs; [
    git-review # We use gerrit
    fossil # I am also moving to Fossil
  ];

  networkingPackages = with pkgs; [
    inetutils # telnet and the like
    wireshark
    tshark
    termshark
  ];

  calculatorPackages = with pkgs; [
    bitwise # https://github.com/mellowcandle/bitwise
    qalculate-gtk
  ];

  performancePackages = [
    flamelens # Custom derivation
    pkgs.xan
    pkgs.xlsx2csv
    pkgs.inferno
    # https://github.com/orhun/binsider
    pkgs.binsider
  ];

  containerPackages = [
    pkgs.docker-client
    pkgs.arion
    pkgs.dive # https://github.com/wagoodman/dive
    pkgs.ctop # https://github.com/bcicen/ctop
    ducker # Custom derivation - https://github.com/robertpsoane/ducker
  ];

  secretsPackages = with pkgs; [
    vault
    sops
  ];

  debuggingPackages = with pkgs; [
    gdb
    # https://cgdb.github.io/docs/cgdb-split.html
    cgdb
  ];

  agenticPackages = [
    kiro-cli # Custom derivation
  ];

  workPackages =
    vcsPackages
    ++ networkingPackages
    ++ calculatorPackages
    ++ performancePackages
    ++ containerPackages
    ++ secretsPackages
    ++ debuggingPackages
    ++ agenticPackages;

  # ============================================================================
  # FINAL ASSEMBLY
  # ============================================================================

  corePackages =
    cliToolsPackages
    ++ desktopPackages
    ++ developmentPackages
    ++ mediaPackages
    ++ flasherPackages
    ++ nixToolsPackages
    ++ tuiGuiPackages
    ++ cursorPackages
    ++ wallpaperPackages
    ++ clipboardPackages
    ++ screenshotPackages
    ++ xdgPackages
    ++ audioPackages
    ++ terminalToolsPackages;

  profilePackages =
    lib.optionals (
      config.systemSettings.profile == "personal" || config.systemSettings.profile == "gaming"
    ) personalGamingPackages
    ++ lib.optionals (config.systemSettings.profile == "personal") personalOnlyPackages
    ++ lib.optionals (config.systemSettings.profile == "gaming") gamingOnlyPackages
    ++ lib.optionals (config.systemSettings.profile == "work") workPackages;

  allSystemPackages = corePackages ++ profilePackages;
in
{
  # If something has been declared with .enable and points to pkgs or homemanager's
  # pkgs we do not need to add it here
  # Here we only do the basic global packages and load up module declarations
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
        nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ prev.makeWrapper ];
        postFixup = (old.postFixup or "") + ''
          for bin in $out/bin/*; do
            wrapProgram "$bin" --set GTK_THEME "Adwaita"
          done
        '';
      });
    })
  ];

  environment.systemPackages = allSystemPackages;
}
