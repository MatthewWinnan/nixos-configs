# Tools & Applications Reference

A categorized reference of all tools and applications managed by this NixOS configuration.

---

## Desktop Environment

| Tool | Description | Config Location |
|------|-------------|-----------------|
| Hyprland | Tiling Wayland compositor | `home/desktop/hypr/hyprland/`, `nix/applications/desktop/hyprland.nix` |
| Waybar | Status bar (themes: Catppuccin, Gruvbox, Elifouts, Omarchy) | `home/desktop/waybar/` |
| Hyprlock | Screen locker | `home/desktop/hypr/hyprlock/` |
| Hypridle | Idle management daemon | `home/desktop/hypr/hypridle.nix` |
| wlogout | Session logout menu | `home/desktop/wlogout/wlogout.nix` |
| Mako | Notification daemon (primary) | `home/desktop/mako.nix` |
| Dunst | Notification daemon (alternative) | `home/desktop/dunst.nix` |
| awww | Animated wallpaper daemon (successor to swww) | Flake input, `home/services/swww.nix` |
| Hyprpaper | Static wallpaper | `home/services/hyprpaper.nix` |
| Waypaper / Waytrogen | Wallpaper selectors | System packages |
| greetd | Login manager | `nix/services/greetd.nix` |

## Application Launchers

| Tool | Description | Config Location |
|------|-------------|-----------------|
| Rofi | Wayland application launcher | `home/tools/rofi/` |
| Anyrun | Wayland launcher (plugin-based) | `home/programs/anyrun/` |
| Walker | GTK-based launcher | `home/tools/walker.nix` |
| Wofi | Wayland launcher (lightweight) | `home/tools/wofi.nix` |
| dmenu | Minimal launcher | System package |

## Shells

| Shell | Description | Config Location |
|-------|-------------|-----------------|
| Fish | Primary shell with syntax highlighting, autosuggestions | `home/shell/fish.nix` |
| Zsh | Alternative shell with fzf-tab, plugins, aliases | `home/shell/zsh/` |
| Bash | Fallback shell | `home/shell/bash.nix` |
| Nushell | Structured data shell | `home/shell/nushell.nix` |
| Starship | Cross-shell prompt | `home/shell/starship.nix` |

## Terminal Emulators

| Terminal | Description | Config Location |
|----------|-------------|-----------------|
| Ghostty | GPU-accelerated terminal | `home/terminal/ghostty.nix` |
| Kitty | Feature-rich GPU terminal | `home/terminal/kitty.nix` |
| Wezterm | Lua-configurable terminal | `home/terminal/wezterm.nix` |

## Editors

| Editor | Description | Config Location |
|--------|-------------|-----------------|
| Nixvim (Neovim) | Fully declarative Neovim — default editor | `nix/applications/nixvim/` |
| Helix | Modal editor (alternative) | `home/programs/helix/` |
| Claude Code | AI coding assistant | `home/programs/claude/` |

## Browsers

| Browser | Description | Config Location |
|---------|-------------|-----------------|
| Qutebrowser | Keyboard-driven browser (default) | `home/programs/qutebrowser/` |
| Schizofox | Hardened Firefox configuration | `home/programs/schizofox/` |
| Chromium | Secondary browser | `home/programs/chromium/` |

## CLI Tools

| Tool | Purpose | Config Location |
|------|---------|-----------------|
| bat | Cat replacement with syntax highlighting | `home/tools/bat/` |
| eza | Modern ls replacement | `home/tools/eza.nix` |
| fzf | Fuzzy finder | `home/tools/fzf.nix` |
| ripgrep | Fast grep replacement | `home/tools/ripgrep.nix` |
| zoxide | Smart cd replacement | `home/tools/zoxide.nix` |
| btop | Resource monitor | `home/tools/btop.nix` |
| tealdeer | tldr pages client | `home/tools/tealdeer.nix` |
| fastfetch | System info display | `home/tools/fastfetch.nix` |
| jq / yq / fq | JSON / YAML / binary data querying | System packages |
| just | Task runner | System package |
| cloc | Code line counter | System package |
| dust | Disk usage analyzer | System package |

## File Managers

| Tool | Description | Config Location |
|------|-------------|-----------------|
| Yazi | Terminal file manager (primary) | `home/programs/yazi/` |
| lf | Terminal file manager (alternative) | `home/tools/lf.nix` |
| Thunar | GUI file manager | `nix/applications/gui/thunar.nix` |

## Git & Version Control

| Tool | Description | Config Location |
|------|-------------|-----------------|
| Git | Version control | `home/tools/git/git.nix` |
| Lazygit | TUI for Git | `home/tools/git/lazygit.nix` |
| GitHub CLI (gh) | GitHub interaction | `home/tools/git/gh.nix` |
| git-review | Gerrit integration (work profile) | System package |
| Fossil | Alternative VCS (work profile) | System package |

## Terminal Multiplexers

| Tool | Description | Config Location |
|------|-------------|-----------------|
| Tmux | Terminal multiplexer | `home/programs/tmux/` |
| Zellij | Modern terminal multiplexer | `home/tools/zellij/` |

## Document Viewers

| Tool | Description | Config Location |
|------|-------------|-----------------|
| Sioyek | PDF viewer (keyboard-driven) | `home/tools/sioyek.nix` |
| Zathura | Minimal PDF viewer | `home/tools/zathura.nix` |
| Evince | GNOME document viewer | `nix/applications/gui/evince.nix` |
| imv | Image viewer | `home/tools/imv.nix` |

## Media & Entertainment

| Tool | Description | Config Location |
|------|-------------|-----------------|
| Spicetify | Customized Spotify | `home/programs/spicetify/` |
| mpv | Minimal video player | System package |
| VLC | Full-featured media player | System package |
| OBS Studio | Screen recording/streaming | `home/programs/obs-studio/` |
| rmpc | MPD client | `home/programs/rmpc/` |
| MPD | Music Player Daemon | `nix/services/mpd.nix` |
| lowfi | Lo-fi music player (custom derivation) | `derivations/lowfi/` |
| cava | Audio visualizer | System package |
| Newsboat | RSS reader | `home/programs/newsboat/` |
| Streamlink | Stream extraction | `home/programs/streamlink/` |

## Communication

| Tool | Description | Config Location |
|------|-------------|-----------------|
| Nixcord | Declarative Discord (Vencord) | `home/programs/nixcord/` |
| Himalaya | CLI email client | `home/programs/himalaya/` |

## Media Streaming (Personal/Gaming profiles)

| Tool | Description |
|------|-------------|
| ani-cli | Anime streaming |
| lobster | Movie/TV streaming |
| mov-cli | General content streaming (custom derivation) |
| Stremio | Media center |
| yt-dlp | Video downloader (custom derivation) |
| spotatui | TUI Spotify client |

## Screenshot & Recording

| Tool | Purpose |
|------|---------|
| grim | Screenshot capture |
| grimblast | Screenshot wrapper |
| slurp | Region selection |
| swappy | Screenshot editor |
| Satty | Screenshot annotation |
| wf-recorder | Screen recording |
| screen_recorder | Custom recording script (custom derivation) |

## Clipboard Management

| Tool | Description | Config Location |
|------|-------------|-----------------|
| clipse | Clipboard manager | `home/services/clipse.nix` |
| cliphist | Clipboard history | `home/services/cliphist.nix` |
| wl-clipboard | Wayland clipboard utilities | System package |
| wl-clip-persist | Persistent clipboard | System package |

## Networking & Security

| Tool | Description | Config Location |
|------|-------------|-----------------|
| NetworkManager + iwd | WiFi management | `nix/networking/default.nix` |
| Tailscale | Mesh VPN | `nix/services/tailscale.nix` |
| fail2ban | Intrusion prevention | `nix/services/fail2ban.nix` |
| SSH | Remote access | `nix/services/ssh.nix` |
| Polkit | Privilege management | `nix/security/polkit.nix` |
| OpenVPN | VPN client (personal profile) | System package |
| Wireshark / tshark / termshark | Network analysis (work profile) | System packages |

## Virtualization & Containers

| Tool | Description | Config Location |
|------|-------------|-----------------|
| Docker | Container runtime | `nix/virtualization/docker.nix` |
| Podman | Rootless containers | `nix/virtualization/podman.nix` |
| Lazydocker | Docker TUI | `home/programs/lazydocker/` |
| ducker | Docker TUI (custom derivation) | `derivations/ducker/` |
| Arion | Docker Compose via Nix | System package |
| dive | Docker image explorer | System package |
| ctop | Container metrics | System package |

## Gaming (Gaming profile)

| Tool | Description | Config Location |
|------|-------------|-----------------|
| Steam | Game platform with Proton | `gaming/modules/steam.nix` |
| ProtonUp | Proton version manager | `gaming/modules/protonup.nix` |
| Gamemode | Performance optimizations | `gaming/modules/gamemode.nix` |
| NoiseTorch | Noise suppression | `gaming/modules/noisetorch.nix` |
| MangoHud | FPS overlay | System package |
| Heroic | Epic/GOG launcher | System package |
| Wine (Wayland) | Windows compatibility | System package |

## Engineering & CAD (Personal/Gaming profiles)

| Tool | Description |
|------|-------------|
| FreeCAD | Parametric 3D CAD (+ custom Wayland wrapper) |
| OpenSCAD | Programmatic 3D CAD |
| KiCad | PCB design (+ custom wrapper) |
| Orca Slicer | 3D print slicer (+ custom Wayland wrapper) |
| PulseView | Logic analyzer |
| Arduino IDE | Embedded development |

## Work-Specific Tools (Work profile)

| Tool | Purpose |
|------|---------|
| Vault | Secrets management |
| SOPS | Encrypted secrets |
| GDB / CGDB | Debugging |
| flamelens | Flame graph viewer (custom derivation) |
| inferno | Flamegraph generator |
| binsider | Binary inspector |
| xan / xlsx2csv | Data processing |
| Kiro CLI | AI coding assistant (custom derivation) |
| LocalSend | Local file sharing |

## Nix Tooling

| Tool | Purpose | Config Location |
|------|---------|-----------------|
| nh | Nix helper for rebuilds | `nix/applications/tools/nh.nix` |
| Alejandra | Nix code formatter | Flake input |
| nix-index-database | Package search + `comma` | Flake input |
| nix-init | Derivation generator | System package |
| nix-output-monitor | Build output viewer | System package |
| nvd | Nix version diff | System package |
| attic-client/server | Binary cache | System packages |

## Desktop Utilities

| Tool | Purpose |
|------|---------|
| GParted | Disk partitioning |
| LibreOffice | Office suite (Adwaita theme override to bypass Stylix) |
| Obsidian | Note-taking |
| Pinta | Image editing |
| Typora | Markdown editor |
| udiskie | Auto-mounting |
| dragon-drop | Drag-and-drop utility |
| warpd | Keyboard-driven mouse |
| Seahorse | GNOME keyring manager |

## Rice / Eye Candy

| Tool | Purpose |
|------|---------|
| cava | Audio visualizer |
| astroterm | Terminal star map |
| cbonsai | Bonsai tree animation |
| cmatrix | Matrix rain |
| pipes-rs | Pipe screensaver |
| voxtype | Voice-to-text |

## Services

| Service | Description | Config Location |
|---------|-------------|-----------------|
| Home Assistant | Home automation (fr3yr only) | `nix/services/home-assistant.nix` |
| Mosquitto | MQTT broker (fr3yr only) | `nix/services/home-assistant.nix` |
| PulseAudio/PipeWire | Audio | `nix/services/pulseaudio.nix` |
| Blueman | Bluetooth | `nix/services/blueman.nix` |
| CUPS | Printing | `nix/services/printing.nix` |
| D-Bus | IPC | `nix/services/dbus.nix` |
| udisks2 | Disk management | `nix/services/udisks2.nix` |
| systemd (custom units) | System services | `nix/services/systemd.nix` |
| dconf | Settings backend | `home/services/dconf.nix`, `nix/applications/desktop/dconf.nix` |

## Known Issues

| Tool | Issue | Reason |
|------|-------|--------|
| Walker | Runner provider (`!` prefix) does not work | The `runner.so` provider is bundled in the nixpkgs `elephant` package and `ELEPHANT_PROVIDER_DIR` is set correctly, but the runner provider fails at runtime. Root cause is unknown — may be a bug in the Walker 2.x / Elephant integration on NixOS, or a missing runtime dependency. Needs further debugging (check `journalctl --user -u elephant` for errors). |
