# NixOS Configuration

A modular, multi-machine NixOS configuration with Home Manager integration, featuring a Hyprland-based desktop environment, comprehensive development tools, and gaming support.

## Features

### Multi-Machine Support
Configuration for 7 different machines, each with tailored settings:
- **ba1dr** - Lenovo Legion Y530-15ICH laptop (gaming/development)
- **h31mda11** - Desktop computer (gaming)
- **od1n** - ThinkPad T580 (coding)
- **fafn1r** - Work machine
- **th0r** - LattePanda Delta (headless homelab)
- **m1m1r** - Proxmox VM on Odroid H3+ (headless)
- **nixos** - WSL configuration

### Desktop Environment
- **Hyprland** - Tiling Wayland compositor with extensive customization
- **Waybar** - Multiple theme options (Catppuccin, Gruvbox, custom)
- **Hyprlock/Hypridle** - Screen locking and idle management
- **wlogout** - Session logout menu
- **Rofi/Anyrun/Walker** - Application launchers
- **Mako/Dunst** - Notification daemons
- **awww/swww** - Animated wallpaper support

### Theming
- **Stylix** - System-wide theming with automatic color generation from wallpaper
- **Catppuccin** - Primary color palette (Macchiato variant)
- **GTK/Icon Themes** - Consistent theming across applications
- **Per-machine wallpaper** - Custom wallpapers for each machine

### Development Tools
- **Nixvim** - Fully declarative Neovim configuration with:
  - LSP support (multiple languages)
  - Treesitter syntax highlighting
  - Telescope fuzzy finder
  - Git integration (lazygit, gitsigns)
  - Completion (nvim-cmp)
  - Many UI enhancements (noice, neo-tree, lualine)
- **Helix** - Alternative modal editor
- **Claude Code** - AI coding assistant
- **Direnv** - Per-directory environment management
- **Development Shells** - Arduino, Zephyr/ZMK keyboard firmware, and more

### Shell Configuration
- **Zsh** - Primary shell with extensive plugin support (fzf-tab, syntax highlighting)
- **Fish** - Alternative shell configuration
- **Starship** - Cross-shell prompt
- **Terminal Emulators** - Ghostty, Kitty, Wezterm

### CLI Tools
- **Yazi/lf** - Terminal file managers
- **bat** - Cat replacement with syntax highlighting
- **eza** - Modern ls replacement
- **fzf** - Fuzzy finder
- **ripgrep** - Fast grep replacement
- **zoxide** - Smart cd replacement
- **btop** - Resource monitor
- **lazygit/lazydocker** - TUI for Git and Docker
- **tmux/zellij** - Terminal multiplexers
- **tealdeer** - tldr pages client

### Applications
- **Schizofox** - Hardened Firefox configuration
- **Chromium** - Secondary browser
- **Qutebrowser** - Keyboard-driven browser
- **Nixcord** - Declarative Discord (Vencord)
- **Spicetify** - Customized Spotify
- **OBS Studio** - Screen recording/streaming
- **Newsboat** - RSS reader
- **Himalaya** - CLI email client
- **rmpc** - MPD client

### Gaming
- **Steam** - With Proton support
- **ProtonUp** - Proton version manager
- **Gamemode** - Performance optimizations
- **NoiseTorch** - Noise suppression for voice chat

### Virtualization
- **Docker** - Container runtime
- **Podman** - Rootless containers

### Custom Derivations
Packages not in nixpkgs or requiring customization:
- **mov-cli** - CLI movie/TV streaming with plugins
- **lowfi** - Lo-fi music player
- **basalt** - Rust application
- **ducker** - Docker TUI
- **flamelens** - Flame graph viewer
- **freecad-wrapped/kicad-wrapped** - CAD tools with custom configs
- **orca-wrapped** - Screen reader
- **kiro-cli** - Custom CLI tool

### Security & Services
- **LUKS encryption** - Full disk encryption via Disko
- **fail2ban** - Intrusion prevention
- **Polkit** - Privilege management
- **SSH** - Secure remote access
- **SOPS-nix** - Secrets management (planned)

### Other Features
- **Disko** - Declarative disk partitioning with LUKS + BTRFS subvolumes
- **nix-index-database** - Package search and `comma` support
- **nh** - Nix helper for easier rebuilds
- **Alejandra** - Nix code formatter
- **NixOS-Hardware** - Hardware-specific optimizations

## Directory Structure

```
.
├── derivations/     # Custom package derivations
├── disko/           # Disk partitioning configurations
├── flake.nix        # Main flake entry point
├── gaming/          # Gaming-related configurations
├── home/            # Home Manager configurations
│   ├── desktop/     # Desktop environment (Hyprland, Waybar, etc.)
│   ├── programs/    # User applications
│   ├── services/    # User services
│   ├── shell/       # Shell configurations
│   ├── terminal/    # Terminal emulators
│   ├── tools/       # CLI tools
│   └── wsl/         # WSL-specific config
├── image_store/     # Wallpapers and images
├── machines/        # Per-machine configurations
├── nix/             # System-level NixOS modules
│   ├── applications/
│   ├── networking/
│   ├── security/
│   ├── services/
│   └── virtualization/
├── shells/          # Development shell environments
└── themes/          # Theming (Stylix, GTK, fonts)
```

## Usage

### Building a Configuration
```bash
# Using nh (recommended)
nh os switch --hostname <machine-name>

# Traditional method
sudo nixos-rebuild switch --flake .#<machine-name>
```

### Development Shells
```bash
# Enter a development shell
nix develop .#<shell-name>

# Available shells: arduino, keymap_editor, mov_cli, zmk, etc.
```

## Special Thanks

The following individuals and projects have been instrumental:

### Individuals

- **[XNM1](https://github.com/XNM1/linux-nixos-hyprland-config-dotfiles)** - Initial basis and inspiration for the project
- **[Sukhmancs](https://github.com/sukhmancs/nixos-configs)** - Rofi-wayland config, [disko luks-btrfs setup](https://github.com/sukhmancs/nixos-configs/tree/f7df37cd6f994be5e5cfbaa1bc9029b8a2399813/disko/luks-btrfs-subvolumes), nixvim LSP config, git config, and Schizofox config
- **[Misterio77](https://github.com/Misterio77/nix-config)** - Boilerplate nix-config inspiration and monitor definitions
- **[Vimjoyer](https://github.com/vimjoyer)** - Excellent YouTube tutorials on [LF](https://www.youtube.com/watch?v=z8y_qRUYEWU), [Stylix](https://www.youtube.com/watch?v=ljHkWgBaQWU), [NH](https://www.youtube.com/watch?v=DnA4xNTrrqY), and [Gaming](https://www.youtube.com/watch?v=qlfm3MEbqYA)
- **[Ampersand](https://www.youtube.com/@Ampersand-xc9jp)** - Great Nix content, [intro video](https://www.youtube.com/watch?v=nLwbNhSxLd4), and [nixvim config](https://github.com/Andrey0189/nixos-config) used as starting point

### Projects

- **[Catppuccin](https://github.com/catppuccin/nix)** - Macchiato color palette, hyprlock/wlogout/waybar theming
- **[NixOS Hardware](https://github.com/NixOS/nixos-hardware)** - Hardware optimizations for Legion Y530-15ICH
- **[Stylix](https://github.com/danth/stylix)** - System-wide theming
- **[Schizofox](https://github.com/schizofox/schizofox)** - Hardened Firefox configuration
- **[Nixvim](https://github.com/nix-community/nixvim)** - Declarative Neovim configuration

And to the wonderful Nix community - more acknowledgements will be added as I continue to learn and borrow from others!

## Imperative Operations

Not everything is fully declarative yet. The following requires manual setup:

### Installation
- **Disko sector blocks** - Manually specify sector block numbers (percentage values don't evaluate correctly)
- **LUKS password** - Set during installation
- **User password** - Run `passwd <username>` after initial install (nixos-install doesn't create user passwords)
- **Monitor configuration** - Update `./machines/<machine>/settings/config.nix` with correct monitor IDs after installation

### Ongoing
- **Browser sign-in** - Both Firefox and Chromium require manual authentication
- **Chromium extensions** - Managed imperatively
- **GitHub SSH/GPG setup** - Requires manual key generation (planning to use SOPS-nix)
- **Steam games** - Game installation managed through Steam
- **Arduino libraries** - Board selection and libraries managed in Arduino IDE
