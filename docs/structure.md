# Repository Structure

```
.
├── flake.nix                  # Entry point — defines all inputs and machine outputs
├── flake.lock                 # Pinned dependency versions
├── .sops.yaml                 # SOPS secrets configuration
├── .gitignore
│
├── machines/                  # Per-machine configurations
│   ├── default.nix            # Builds all nixosConfigurations with appropriate modules
│   ├── options/               # Shared option declarations
│   │   ├── deviceSettings.nix # Device type, headless flag, monitor definitions
│   │   ├── systemSettings.nix # Hostname, arch, profile, locale, timezone
│   │   ├── userSettings.nix   # Username, name, email, browser, waybar theme
│   │   └── imageSettings.nix  # Wallpaper/image settings
│   ├── ba1dr/                 # Lenovo Legion Y530 (gaming/dev)
│   │   ├── settings/config.nix
│   │   ├── home/default.nix   # Home Manager imports for this machine
│   │   └── nix/               # hardware-configuration.nix, boot.nix
│   ├── h31mda11/              # Desktop gaming PC
│   ├── od1n/                  # ThinkPad T580 (work)
│   ├── fafn1r/                # Work VM
│   ├── nixos/                 # WSL configuration
│   │   └── nix/wsl/           # WSL-specific NixOS modules
│   ├── fr3yr/                 # Raspberry Pi 4 (Home Assistant)
│   │   └── nix/sops.nix       # SOPS secrets for HA
│   ├── th0r/                  # LattePanda Delta (headless)
│   └── m1m1r/                 # Proxmox VM (headless)
│
├── nix/                       # System-level NixOS modules (desktop machines)
│   ├── default.nix            # Imports all sub-modules
│   ├── applications/
│   │   ├── desktop/           # Hyprland, dconf, nm-applet
│   │   ├── gui/               # Thunar, Evince, Seahorse
│   │   ├── nixvim/            # Full Neovim configuration (see nixvim.md)
│   │   ├── packages/          # All system packages, organized by profile
│   │   └── tools/             # nh, bandwhich, wireshark, localsend
│   ├── environment/           # Environment variables (EDITOR, BROWSER, XDG, etc.)
│   ├── headless/              # Reduced module set for headless machines
│   │   ├── default.nix        # Imports packages, services, networking, user, nixvim
│   │   ├── packages.nix       # Minimal package set for headless
│   │   ├── services.nix
│   │   └── environment.nix
│   ├── networking/            # NetworkManager, iwd, firewall
│   ├── security/              # Polkit rules and service
│   ├── services/              # System services
│   │   ├── fail2ban.nix
│   │   ├── greetd.nix         # Login manager
│   │   ├── home-assistant.nix # HA config (fr3yr)
│   │   ├── mpd.nix            # Music Player Daemon
│   │   ├── printing.nix       # CUPS
│   │   ├── pulseaudio.nix     # Audio
│   │   ├── ssh.nix
│   │   ├── systemd.nix        # Custom systemd units
│   │   ├── tailscale.nix      # Mesh VPN
│   │   ├── udisks2.nix
│   │   └── wsl_overrides.nix  # WSL service overrides
│   ├── user/                  # User account creation
│   └── virtualization/        # Docker, Podman
│
├── home/                      # Home Manager configurations
│   ├── default.nix            # Top-level imports
│   ├── desktop/               # Desktop environment
│   │   ├── hypr/              # Hyprland, Hyprlock, Hypridle
│   │   ├── waybar/            # Settings and styles per theme
│   │   ├── wlogout/           # Logout menu
│   │   ├── mako.nix           # Notifications
│   │   ├── dunst.nix          # Notifications (alt)
│   │   ├── stylix.nix         # Home-level Stylix overrides
│   │   └── xdg.nix            # XDG MIME associations
│   ├── programs/              # User applications
│   │   ├── anyrun/            # Launcher
│   │   ├── chromium/          # Browser
│   │   ├── claude/            # AI assistant
│   │   ├── helix/             # Editor
│   │   ├── himalaya/          # Email
│   │   ├── lazydocker/        # Docker TUI
│   │   ├── newsboat/          # RSS (with scripts and URLs)
│   │   ├── nixcord/           # Discord
│   │   ├── obs-studio/        # Recording
│   │   ├── qutebrowser/       # Browser
│   │   ├── rmpc/              # MPD client
│   │   ├── satty/             # Screenshot annotation
│   │   ├── schizofox/         # Hardened Firefox
│   │   ├── spicetify/         # Spotify
│   │   ├── streamlink/        # Stream extraction
│   │   ├── tmux/              # Multiplexer
│   │   ├── yazi/              # File manager (with theme)
│   │   └── direnv.nix         # Per-directory environments
│   ├── services/              # User-level services
│   │   ├── cliphist.nix       # Clipboard history
│   │   ├── clipse.nix         # Clipboard manager
│   │   ├── dconf.nix          # Settings
│   │   ├── hyprpaper.nix      # Wallpaper
│   │   ├── swww.nix           # Animated wallpaper
│   │   └── udiskie.nix        # Auto-mount
│   ├── shell/                 # Shell configurations
│   │   ├── fish.nix           # Primary shell
│   │   ├── zsh/               # Alt shell (plugins, aliases, rc, init)
│   │   ├── bash.nix           # Fallback
│   │   ├── nushell.nix        # Structured data shell
│   │   └── starship.nix       # Prompt
│   ├── terminal/              # Terminal emulators
│   │   ├── ghostty.nix
│   │   ├── kitty.nix
│   │   └── wezterm.nix
│   ├── tools/                 # CLI tools
│   │   ├── bat/               # Cat replacement (with custom theme)
│   │   ├── git/               # Git, lazygit, gh
│   │   ├── rofi/              # Launcher
│   │   ├── zellij/            # Multiplexer (with config)
│   │   ├── btop.nix           # Resource monitor
│   │   ├── eza.nix            # ls replacement
│   │   ├── fastfetch.nix      # System info
│   │   ├── fzf.nix            # Fuzzy finder
│   │   ├── imv.nix            # Image viewer
│   │   ├── lf.nix             # File manager
│   │   ├── ripgrep.nix        # Grep replacement
│   │   ├── sioyek.nix         # PDF viewer
│   │   ├── tealdeer.nix       # tldr
│   │   ├── walker.nix         # Launcher
│   │   ├── wofi.nix           # Launcher
│   │   ├── zathura.nix        # PDF viewer
│   │   └── zoxide.nix         # Smart cd
│   └── wsl/                   # WSL-specific home config
│
├── themes/                    # System-wide theming
│   ├── stylix.nix             # Stylix config (wallpaper-based colors, dark polarity)
│   ├── fonts.nix              # JetBrains Mono, Noto, Nerd Fonts, Font Awesome
│   ├── gtk.nix                # GTK theme
│   └── icon-themes.nix        # Icon themes
│
├── gaming/                    # Gaming configurations
│   ├── modules/               # Shared gaming modules
│   │   ├── steam.nix          # Steam with Proton
│   │   ├── protonup.nix       # Proton-GE manager
│   │   ├── gamemode.nix       # Performance mode
│   │   └── noisetorch.nix     # Noise suppression
│   ├── ba1dr/                 # Legion-specific (OpenGL, video drivers)
│   └── h31mda11/              # Desktop-specific (OpenGL, video drivers)
│
├── derivations/               # Custom package derivations
│   ├── basalt/                # Rust package
│   ├── ducker/                # Docker TUI
│   ├── flamelens/             # Flame graph viewer
│   ├── freecad-wrapped/       # FreeCAD with custom config
│   ├── kicad-wrapped/         # KiCad with custom config
│   ├── kiro-cli/              # Kiro CLI tool (with update script)
│   ├── lowfi/                 # Lo-fi music player
│   ├── mov-cli/               # CLI streaming (with plugins, config, packages)
│   ├── orca-wrapped/          # Orca Slicer Wayland wrapper
│   └── screen_record.nix      # Screen recording script
│
├── disko/                     # Declarative disk partitioning
│   ├── ba1dr.nix              # LUKS + BTRFS subvolumes
│   ├── h31mda11.nix
│   ├── od1n.nix
│   └── m1m1r.nix
│
├── image_store/               # Wallpapers and images
│   ├── images/                # Actual image files
│   ├── ba1dr.nix              # Per-machine wallpaper selection
│   ├── h31mda11.nix
│   ├── od1n.nix
│   ├── fafn1r.nix
│   ├── th0r.nix
│   └── nixos.nix
│
├── secrets/                   # SOPS-encrypted secrets
│   └── fr3yr.yaml             # Home Assistant secrets
│
└── docs/                      # Documentation (you are here)
```

## Architecture Overview

### Machine Configuration Flow

```
flake.nix
  └── machines/default.nix          # Selects modules per machine
        ├── machines/<host>/         # Machine-specific config
        │     ├── settings/config.nix  # Device/system/user settings
        │     ├── nix/               # Hardware config, boot
        │     └── home/              # Machine-specific HM imports
        │
        ├── nix/                     # System modules (desktop)
        │   OR nix/headless/         # System modules (headless)
        │
        ├── themes/                  # Stylix, fonts, GTK
        ├── gaming/                  # Gaming modules (if applicable)
        └── home/                    # Home Manager modules
```

### Supporting Directory Flows

```
derivations/                         # Custom packages built outside nixpkgs
  └── <pkg>/default.nix              # Each derivation is callPackage'd
        └── referenced by nix/applications/packages/default.nix

disko/                               # Declarative disk layouts
  └── <host>.nix                     # Used at install time, not imported at build

image_store/                         # Wallpaper selection per machine
  ├── images/                        # Actual image files
  └── <host>.nix                     # Sets config.images.stylix_wallpaper
        └── consumed by themes/stylix.nix → Stylix color generation

secrets/                             # SOPS-encrypted YAML files
  └── <host>.yaml                    # Decrypted at activation via sops-nix
        └── referenced by machines/<host>/nix/sops.nix

gaming/                              # Per-machine GPU config + shared modules
  ├── modules/                       # steam, protonup, gamemode, noisetorch
  └── <host>/                        # opengl.nix, video_drivers.nix
        └── imported by machines/<host>/nix/default.nix
```

### System Module Flow (`nix/`)

```
nix/default.nix                      # Desktop machines entry point
  ├── applications/
  │     ├── desktop/                 # Hyprland, dconf, nm-applet
  │     ├── gui/                     # Thunar, Evince, Seahorse
  │     ├── nixvim/                  # Full Neovim config (opts, keymaps, plugins)
  │     ├── packages/default.nix     # All system packages, profile-conditional
  │     └── tools/                   # nh, bandwhich, wireshark, localsend
  ├── services/                      # greetd, mpd, ssh, printing, pulseaudio, etc.
  ├── networking/                    # NetworkManager, iwd, firewall
  ├── security/                      # Polkit rules + service
  ├── environment/                   # Env vars (EDITOR, XDG, Wayland)
  └── user/                          # User account creation

nix/headless/default.nix             # Headless machines entry point
  ├── packages.nix                   # Minimal CLI packages
  ├── services.nix                   # Reduced service set
  ├── environment.nix                # Minimal env vars
  ├── ../networking/                 # Shared networking config
  ├── ../user/                       # Shared user config
  └── ../applications/nixvim/        # Nixvim (shared with desktop)
```

### Home Manager Flow (`home/`)

```
home/default.nix                     # Entry point, imported per-machine
  ├── desktop/                       # Desktop environment
  │     ├── hypr/                    # Hyprland, Hyprlock, Hypridle
  │     ├── waybar/                  # Status bar (settings + style per theme)
  │     ├── wlogout/                 # Logout menu
  │     ├── mako.nix / dunst.nix    # Notifications
  │     ├── stylix.nix              # Home-level Stylix overrides
  │     └── xdg.nix                 # MIME type associations
  ├── programs/                      # User applications (each self-contained)
  │     ├── schizofox/ chromium/ qutebrowser/   # Browsers
  │     ├── nixcord/ spicetify/ obs-studio/     # Media & social
  │     ├── yazi/ tmux/ helix/ claude/          # Productivity
  │     └── direnv.nix                          # Per-dir environments
  ├── shell/                         # Shell configs
  │     ├── fish.nix                 # Primary shell
  │     ├── zsh/                     # Alt shell (plugins, aliases, rc)
  │     ├── bash.nix / nushell.nix   # Additional shells
  │     └── starship.nix            # Cross-shell prompt
  ├── terminal/                      # Emulators: ghostty, kitty, wezterm
  ├── tools/                         # CLI tools: bat, git, fzf, eza, rofi, etc.
  ├── services/                      # User services: clipboard, wallpaper, mount
  └── wsl/                           # WSL-specific overrides
```

Each machine selects which home modules to import via `machines/<host>/home/default.nix`, allowing per-machine customization of the shared module set.

### Profile System

The `systemSettings.profile` option drives conditional package installation and LSP server selection:

- `personal` — Media streaming, embedded dev, CAD, 3D printing, OpenVPN
- `gaming` — All personal packages + MangoHud, Heroic, Wine, Steam
- `work` — VCS tools, networking analysis, containers, debugging, secrets management, Kiro CLI

### Desktop vs Headless

Desktop machines import `nix/default.nix` which pulls in the full module tree (applications, services, networking, security, environment, user). Headless machines import `nix/headless/default.nix` which provides a minimal set (basic packages, networking, user, nixvim).
