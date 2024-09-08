{config, pkgs, lib, inputs, ...}: {

  # Here we do the typical packages and load up module declerations
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = ["python-2.7.18.8" "electron-25.9.0"];
  };

  environment.systemPackages = with pkgs; [
    # Default desktop apps
    chromium
    gparted
    obsidian
    blueman

    # Default coding stuff
    gnumake
    gcc
    nodejs
    python
    (python3.withPackages (ps: with ps; [ requests ]))

    # Default CLI tools for everyone
    wget
    git
    fastfetch
    htop
    btop
    eza
    openssl
    fish
    nh
    nix-output-monitor
    nvd

    # TUI/GUI utils
    dmenu
    wofi
    xdragon
    bat
    pistol
    kitty
    nwg-look
    hyprcursor
    helix
    rofi-wayland
    dunst

    # Cursors
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default

    # Wallpaper
    waypaper
    inputs.swww.packages.${system}.swww

    # Wayland stuff
    xwayland
    wl-clipboard
    cliphist

    # WMs and stuff
    waybar
    xdg-desktop-portal-hyprland
    wttrbar # Weather
    hypridle
    hyprlock
    wlogout # For logout screen

    # Sound support
    pavucontrol
    pipewire
    pulseaudio
    pamixer

    # Screenshotting
    grim
    grimblast
    slurp
    flameshot
    swappy

  ] ++ lib.optionals (config.systemSettings.profile == "personal" || config.systemSettings.profile == "gaming") [
      # Desktop apps for my personal and gaming use
      discord
  ] ++ lib.optionals (config.systemSettings.profile == "personal")[
      # Only for personal use
      orca-slicer
      arduino-ide
      openvpn
      skypeforlinux

      # Embedded coding, see arduino-ide too
      adafruit-nrfutil
  ] ++ lib.optionals (config.systemSettings.profile == "work")[

      # Only for professional life
      openvpn
      skypeforlinux

    ];

}
