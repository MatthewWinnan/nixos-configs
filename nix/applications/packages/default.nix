{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  # Custom derivations
  lowfi = pkgs.callPackage ../../../derivations/lowfi/lowfi.nix {};
  screen_recorder = pkgs.callPackage ../../../derivations/screen_record.nix {};
  flamelens = pkgs.callPackage ../../../derivations/flamelens {};
  kiro-cli = pkgs.callPackage ../../../derivations/kiro-cli {};
  yt-dlp = pkgs.callPackage ../../../derivations/mov-cli/packages/yt-dlp.nix {};
  ducker = pkgs.callPackage ../../../derivations/ducker {};
  exiled-exchange-2 = pkgs.callPackage ../../../derivations/exiled-exchange-2 {};
  kicad-wrapped = pkgs.callPackage ../../../derivations/kicad-wrapped {};
  orca-wrapped = pkgs.callPackage ../../../derivations/orca-wrapped {};
  freecad-wrapped = pkgs.callPackage ../../../derivations/freecad-wrapped {};
  keifu = pkgs.callPackage ../../../derivations/keifu {};

  # ============================================================================
  # CORE PACKAGES - Essential system tools for all profiles
  # ============================================================================

  cliToolsPackages = with pkgs; [
    csvlens # TUI CSV viewer
    fq # Binary data querying
    htop # Process monitoring
    jq # JSON querying
    just # Task runner
    libxml2 # For faster XML scraping
    openssl # Cryptography toolkit
    ouch # Painless compression/decompression (tar, zip, gz, 7z, xz, bz2, zstd, rar, lz4, snappy, br)
    poppler-utils # PDF tools (pdftotext, pdfinfo) + pdftoppm (required for Claude Code to read PDFs)
    tcpdump # For packet inspection
    termpdfpy # Terminal PDF viewer (kitty graphics)
    unrar # Archive extraction
    unzip # Archive extraction
    wget # File downloading
    wttrbar # Weather
    yq # YAML querying
  ];

  desktopPackages = with pkgs; [
    gparted # Disk partitioning
    libreoffice # Office suite
    obsidian # Note-taking
    pinta # https://www.pinta-project.com/
    udiskie # Automounter
  ];

  developmentPackages = with pkgs; [
    gcc
    gnumake
    (python3.withPackages (
      ps:
        with ps; [
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
    # https://github.com/ImageMagick/ImageMagick
    imagemagick
    typora # https://typora.io/
    # https://github.com/videolan/vlc
    vlc # Full-featured media player
    wf-recorder # Screen recording (CLI access)
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
    # Formatter
    inputs.alejandra.defaultPackage.${pkgs.stdenv.hostPlatform.system}
    # For caching setup
    attic-client
    attic-server
    # Linting
    deadnix # Find unused nix code
    # DOCS -> https://github.com/nix-community/nix-init?tab=readme-ov-file
    nix-init # Generates derivations from git projects
    nix-output-monitor # Nix build output
    nvd # Nix version diff
    statix # Nix anti-pattern linter
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
    # https://github.com/bootandy/dust
    dust
    hyprcursor # Cursor theme
    # https://github.com/pythops/impala
    impala
    pistol # File previewer
    # https://github.com/samuela/remod?tab=readme-ov-file
    remod # File permission editor
    # https://github.com/gferraro/voxtype
    voxtype-vulkan # Voice-to-text for Wayland
    # https://github.com/rvaiya/warpd?tab=readme-ov-file#wayland
    warpd # Keyboard-driven mouse
    # https://github.com/tsowell/wiremix
    wiremix
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
    screen_recorder # Custom recorder
    slurp # Region selection
    swappy # Screenshot editor
  ];

  xdgPackages = with pkgs; [
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xdg-utils
    xwayland
  ];

  audioPackages = with pkgs; [
    pamixer # PulseAudio CLI mixer
    pavucontrol # PulseAudio GUI
    pipewire # Multimedia routing
    pulseaudio # Audio server
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
    # https://github.com/theryangeary/choose
    choose # Simpler cut alternative
    # https://github.com/bensadeh/circumflex
    circumflex # Hacker News reader
    # https://github.com/nik-rev/countryfetch
    countryfetch # System info (country theme)
    # https://github.com/Dr-Noob/cpufetch?tab=readme-ov-file#8-cpufetch-for-gpus-gpufetch
    cpufetch # CPU info display
    # https://github.com/tuna-f1sh/cyme
    cyme # USB device lister
    # https://github.com/mr-karan/doggo
    doggo # Prettier dig alternative
    # https://github.com/charmbracelet/glow
    glow # Terminal markdown renderer
    # https://github.com/orf/gping
    gping # Ping with graph
    # https://github.com/sharkdp/hexyl
    hexyl # Colorized hex viewer
    # https://github.com/sharkdp/hyperfine
    hyperfine # CLI benchmarking tool
    # https://github.com/denisidoro/navi
    navi # Interactive cheatsheet
    # https://github.com/rofl0r/ncdu
    ncdu # Interactive disk usage explorer
    # https://github.com/dalance/procs
    procs # Prettier ps replacement
    # https://github.com/AlDanial/cloc
    tokei # Code statistics (faster cloc replacement)
    # https://github.com/fujiapple852/trippy
    trippy # Visual traceroute TUI
    # https://github.com/ducaale/xh
    xh # Colorized curl alternative
  ];

  # ============================================================================
  # ROLE-SPECIFIC: Personal + Gaming shared packages
  # ============================================================================

  mediaStreamingPackages = [
    pkgs.ani-cli # Anime streaming
    inputs.lobster.packages.${pkgs.stdenv.hostPlatform.system}.lobster # Movie streaming
    pkgs.mov-cli # General content streaming
    # https://github.com/mpv-player/mpv
    pkgs.mpv # Video player (pulls yt-dlp for URL playback)
    pkgs.stremio-linux-shell # Stremio media center
    yt-dlp # Video downloader (custom derivation)
  ];

  musicPackages = [
    lowfi # TUI Lowfi player (custom derivation)
    pkgs.mpc # Minimal mpd client
  ];

  embeddedDevPackages = with pkgs; [
    adafruit-nrfutil
    arduino-ide
  ];

  cadPackages = [
    freecad-wrapped # Custom derivation
    pkgs.freecad-wayland
    pkgs.openscad-unstable
  ];

  slicerPackages = [
    orca-wrapped # Custom derivation
    pkgs.orca-slicer
  ];

  pcbPackages = [
    kicad-wrapped # Custom derivation
    pkgs.kicad
    pkgs.pulseview # Logic analyzer
  ];

  ricePackages = with pkgs; [
    # Animations
    # https://github.com/da-luce/astroterm
    astroterm # Star map
    # Visualizers
    # https://github.com/karlstav/cava
    cava # Audio visualizer
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
      # https://github.com/wookayin/gpustat
      gpustat # GPU monitoring TUI
      # https://mqtt-explorer.com/
      mqtt-explorer # MQTT debugging GUI
      nodejs # includes npx (for MCP servers)
      sops # For secrets
      # https://tectonic-typesetting.github.io/
      tectonic # Self-contained LaTeX engine (downloads packages on demand)
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
    # https://github.com/Kvan7/Exiled-Exchange-2
    exiled-exchange-2
    # https://heroicgameslauncher.com/
    heroic
    # DOCS Check more on mangohub -> https://github.com/flightlessmango/MangoHud
    mangohud
    # https://github.com/meehl/rusty-path-of-building
    rusty-path-of-building
    # https://mynixos.com/nixpkgs/package/wine-wayland
    wine-wayland
  ];

  # ============================================================================
  # ROLE-SPECIFIC: Work
  # ============================================================================

  vcsPackages = with pkgs; [
    fossil # I am also moving to Fossil
    git-review # We use gerrit
    glab # GitLab CLI
    tig # TUI git log/blame/diff browser
  ];

  networkingPackages = with pkgs; [
    inetutils # telnet and the like
    mosh # Mobile shell — persistent SSH alternative (UDP, survives roaming)
    termshark
    tshark
    wireshark
  ];

  calculatorPackages = with pkgs; [
    bitwise # https://github.com/mellowcandle/bitwise
    qalculate-gtk
  ];

  performancePackages = [
    # https://github.com/orhun/binsider
    pkgs.binsider
    flamelens # Custom derivation
    pkgs.inferno
    pkgs.xan
    # https://github.com/bgreenwell/xleak
    pkgs.xleak
    pkgs.xlsx2csv
  ];

  containerPackages = [
    pkgs.arion
    pkgs.ctop # https://github.com/bcicen/ctop
    pkgs.dive # https://github.com/wagoodman/dive
    pkgs.docker-client
    ducker # Custom derivation - https://github.com/robertpsoane/ducker
    pkgs.lazydocker # https://github.com/jesseduffield/lazydocker
  ];

  secretsPackages = with pkgs; [
    age
    sops
    vault
  ];

  debuggingPackages = with pkgs; [
    # https://cgdb.github.io/docs/cgdb-split.html
    cgdb
    dmidecode
    gdb
    ipmitool
    # https://github.com/darrenburns/posting
    posting # TUI API client (like Postman in terminal)
    # https://github.com/yassinebridi/serpl
    serpl # TUI search and replace across files
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
    )
    personalGamingPackages
    ++ lib.optionals (config.systemSettings.profile == "personal") personalOnlyPackages
    ++ lib.optionals (config.systemSettings.profile == "gaming") gamingOnlyPackages
    ++ lib.optionals (config.systemSettings.profile == "work") workPackages;

  allSystemPackages = corePackages ++ profilePackages;
in {
  # If something has been declared with .enable and points to pkgs or homemanager's
  # pkgs we do not need to add it here
  # Here we only do the basic global packages and load up module declarations
  nixpkgs.config = {
    allowUnfree = true;
    # NB added since arduino still uses this but not security vul technically
    permittedInsecurePackages = [
      "python3.13-ecdsa-0.19.1"
      "python3.13-ecdsa-0.19.2"
    ];
  };

  # Override libreoffice to use dark GTK theming (matching Stylix)
  nixpkgs.overlays = [
    (_final: prev: {
      libreoffice = prev.symlinkJoin {
        name = "libreoffice-dark";
        paths = [prev.libreoffice];
        buildInputs = [prev.makeWrapper];
        postBuild = ''
          for bin in $out/bin/*; do
            wrapProgram "$bin" \
              --set GTK_THEME "adw-gtk3-dark"
          done
        '';
      };
    })
  ];

  environment.systemPackages = allSystemPackages;

  # Allow running dynamically linked binaries (e.g. kiro-cli's bundled bun)
  programs.nix-ld.enable = true;
}
