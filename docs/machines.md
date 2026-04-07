# Machine Inventory

All machines share a common options system defined in `machines/options/` with three setting categories:
- `deviceSettings` — Hardware type (`laptop`/`desktop`/`vm`), headless flag, monitor definitions
- `systemSettings` — Architecture, hostname, profile (`personal`/`work`/`gaming`), locale, timezone
- `userSettings` — Username, name, email, default browser, waybar theme

---

## Desktop Machines (GUI)

### ba1dr — Lenovo Legion Y530-15ICH

| Setting | Value |
|---------|-------|
| Type | Laptop |
| Arch | x86_64-linux |
| Profile | Gaming |
| Username | matthew |
| Monitors | HDMI-A-1 (1920×1080, primary) |
| Waybar Theme | Gruvbox |
| Headless | No |

- Uses `nixos-hardware` Lenovo Legion Y530-15ICH module for hardware optimizations
- Has dedicated gaming config in `gaming/ba1dr/` (OpenGL, video drivers)
- Disko LUKS+BTRFS disk config in `disko/ba1dr.nix`
- Modules: nixvim, stylix, nix-index, home-manager

### h31mda11 — Desktop Gaming PC

| Setting | Value |
|---------|-------|
| Type | Desktop |
| Arch | x86_64-linux |
| Profile | Gaming |
| Username | matthew |
| Monitors | HDMI-A-1 (1920×1080, primary, 60Hz), HDMI-A-2 (1920×1080, rotated 270°, 100Hz) |
| Waybar Theme | Omarchy |
| Headless | No |

- Dual-monitor setup with one rotated vertically
- Dedicated gaming config in `gaming/h31mda11/` (OpenGL, video drivers)
- Disko LUKS+BTRFS disk config in `disko/h31mda11.nix`
- SOPS secrets management enabled
- Modules: nixvim, stylix, nix-index, home-manager, sops

### od1n — ThinkPad T580

| Setting | Value |
|---------|-------|
| Type | Work (laptop) |
| Arch | x86_64-linux |
| Profile | Work |
| Username | matthew |
| Monitors | DP-5 (1920×1080, primary), HDMI-A-2 (1024×768), eDP-1 (1920×1080) |
| Waybar Theme | Catppuccin (default) |
| Headless | No |

- Triple-monitor setup (two external + built-in)
- Work profile enables additional LSP servers (Docker, Nginx, docker-compose)
- Work-specific packages: git-review, fossil, wireshark, vault, sops, gdb, kiro-cli
- Disko LUKS+BTRFS disk config in `disko/od1n.nix`
- Modules: nixvim, stylix, nix-index, home-manager

### fafn1r — Work VM

| Setting | Value |
|---------|-------|
| Type | Laptop |
| Arch | x86_64-linux |
| Profile | Work |
| Username | matthew |
| Monitors | Virtual-1 (1920×1080, primary) |
| Waybar Theme | Omarchy |
| Headless | No |

- Virtual machine for work use (Virtual-1 monitor)
- Work profile with same tooling as od1n
- Modules: nixvim, stylix, nix-index, home-manager

### nixos — WSL Configuration

| Setting | Value |
|---------|-------|
| Type | Laptop |
| Arch | x86_64-linux |
| Profile | Work |
| Username | matthew |
| Monitors | None |
| Headless | No |

- Windows Subsystem for Linux configuration
- Uses `nixos-wsl` module
- WSL-specific overrides in `home/wsl/` and `nix/services/wsl_overrides.nix`
- Modules: nixvim, nix-index, stylix, wsl

---

## Headless Machines (No GUI)

### fr3yr — Raspberry Pi 4

| Setting | Value |
|---------|-------|
| Type | VM (embedded) |
| Arch | aarch64-linux |
| Profile | Personal |
| Username | h3rm3s |
| Headless | Yes |

- Runs Home Assistant with MQTT (Mosquitto), ESPHome, Zigbee (ZHA) support
- Uses `nixos-hardware` Raspberry Pi 4 module
- SOPS secrets management for sensitive Home Assistant config (lat/long/elevation)
- Tailscale for remote access
- Modules: nixvim, nix-index, sops, raspberry-pi-4

### th0r — LattePanda Delta

| Setting | Value |
|---------|-------|
| Type | Laptop |
| Arch | x86_64-linux |
| Profile | Personal |
| Username | h3rm3s |
| Monitors | HDMI-A-2 (1920×1080, primary) |
| Headless | Yes |

- Homelab server on LattePanda Delta SBC
- Headless despite having a monitor definition (for potential display use)
- Modules: nixvim, nix-index

### m1m1r — Proxmox VM (Odroid H3+)

| Setting | Value |
|---------|-------|
| Type | VM |
| Arch | x86_64-linux |
| Profile | Personal |
| Username | matthew |
| Headless | Yes |

- Virtual machine running on Proxmox on Odroid H3+ hardware
- Disko LUKS+BTRFS disk config in `disko/m1m1r.nix`
- Modules: nixvim, nix-index

---

## Module Matrix

| Machine | nixvim | stylix | home-manager | nix-index | sops | wsl | nixos-hardware |
|---------|--------|--------|-------------|-----------|------|-----|----------------|
| ba1dr | ✓ | ✓ | ✓ | ✓ | | | Legion Y530 |
| h31mda11 | ✓ | ✓ | ✓ | ✓ | ✓ | | |
| od1n | ✓ | ✓ | ✓ | ✓ | | | |
| fafn1r | ✓ | ✓ | ✓ | ✓ | | | |
| nixos | ✓ | ✓ | | ✓ | | ✓ | |
| fr3yr | ✓ | | | ✓ | ✓ | | RPi 4 |
| th0r | ✓ | | | ✓ | | | |
| m1m1r | ✓ | | | ✓ | | | |

Desktop machines use the full `nix/` module tree. Headless machines use `nix/headless/` which imports a reduced set: packages, services, networking, environment, user, and nixvim.
