# NixOS Configuration

A modular, multi-machine NixOS configuration with Home Manager integration, featuring a Hyprland-based desktop environment, comprehensive development tools, and gaming support.

## Documentation

Detailed documentation is available in the [`docs/`](docs/) directory:

- [Machine Inventory](docs/machines.md) — All 8 machines with their roles, settings, and module matrix
- [Tools & Applications](docs/tools.md) — Categorized reference of every tool and application
- [Repository Structure](docs/structure.md) — Directory layout, module flow, and architecture overview
- [Nixvim Configuration](docs/nixvim.md) — Neovim setup: plugins, LSP servers, keymaps, options
- [Theming](docs/theming.md) — Stylix, fonts, wallpapers, cursor, and Waybar themes
- [Custom Derivations](docs/derivations.md) — Packages built from source or wrapped for this config
- [Disk & Secrets](docs/disk-and-secrets.md) — LUKS+BTRFS partitioning via Disko and SOPS secrets

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
