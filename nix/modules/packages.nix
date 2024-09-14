{config, pkgs, lib, inputs, ...}: {
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
    htop
    btop
    eza
    openssl
    nh
    nix-output-monitor
    nvd

    # TUI/GUI utils
    dmenu
    xdragon
    bat
    pistol
    hyprcursor
    zathura

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
      rpi-imager

  ] ++ lib.optionals (config.systemSettings.profile == "work")[

      # Only for professional life
      openvpn
      skypeforlinux

      # I still need to flash
      rpi-imager

    ];

}
