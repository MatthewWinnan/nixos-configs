{ pkgs, inputs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = ["python-2.7.18.8" "electron-25.9.0"];
  };

  environment.systemPackages = with pkgs; [
    # Desktop apps
    chromium
    discord
    gparted
    obsidian
    anydesk
    orca-slicer

    # Coding stuff
    gnumake
    gcc
    nodejs
    python
    (python3.withPackages (ps: with ps; [ requests ]))

    # CLI utils
    wget
    git
    fastfetch
    htop
    btop
    nix-search-cli
    eza
    openssl
    fish
    nh
    nix-output-monitor
    nvd

    # TUI/GUI utils
    dmenu
    wofi
    rofi
    xdragon
    bat
    pistol
    kitty
    nwg-look
    
    # Wallpaper
    waypaper 
    inputs.swww.packages.${system}.swww

    # Wayland stuff
    xwayland
    wl-clipboard
    cliphist

    # WMs and stuff
    hyprland
    waybar
    xdg-desktop-portal-hyprland
    wttrbar # Weather
    
    # My custom widgets
    ags
    bun

    # Sound
    pipewire
    pulseaudio
    pamixer

    # GPU stuff 

    # Screenshotting
    grim
    grimblast
    slurp
    flameshot
    swappy
    
    # Work
    openvpn
    skypeforlinux

    # Other
    home-manager
    spice-vdagent
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    papirus-nord
  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];
}
