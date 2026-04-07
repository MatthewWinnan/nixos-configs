# Custom Derivations

Packages not available in nixpkgs or requiring custom wrapping/configuration. Located in `derivations/`.

| Derivation | Description | Type |
|------------|-------------|------|
| `kiro-cli` | Kiro CLI AI coding tool. Includes `update.sh` for version bumps. | Binary fetch |
| `mov-cli` | CLI movie/TV streaming tool with plugin system (plugins, config, packages subdirs) | Python package |
| `lowfi` | Lo-fi music player TUI | Rust package |
| `flamelens` | Flame graph viewer | Binary fetch |
| `ducker` | Docker TUI client | Binary fetch |
| `basalt` | Rust package (includes Cargo.lock) | Rust/Cargo build |
| `screen_record.nix` | Screen recording shell script wrapper | Script |
| `kicad-wrapped` | KiCad with custom Wayland/config wrapping | Wrapper |
| `orca-wrapped` | Orca Slicer wrapped for Wayland compatibility | Wrapper |
| `freecad-wrapped` | FreeCAD with custom configuration wrapping | Wrapper |

## Flake Inputs (External)

Several tools are pulled directly from flake inputs rather than nixpkgs:

| Input | Package | Notes |
|-------|---------|-------|
| `awww` | awww wallpaper daemon | Successor to swww, from Codeberg |
| `lobster` | Movie streaming CLI | |
| `manga-tui` | Manga browser TUI | |
| `anyrun` | Application launcher | With plugins |
| `himalaya` | Email client | From Pimalaya |
| `schizofox` | Hardened Firefox | |
| `nixcord` | Declarative Discord | Vencord-based |
| `spicetify-nix` | Spotify customization | |
| `rose-pine-hyprcursor` | Cursor theme | |
| `alejandra` | Nix formatter | Pinned to 4.0.0 |
| `nh` | Nix helper | Master branch |
| `nix-vscode-extensions` | VSCode extensions | |

## Unstable Channel Usage

Some packages are pulled from `nixpkgs-unstable` when the stable version is insufficient:

- `stremio-linux-shell` — With custom build fix for cargo deps path
- `spotatui` — TUI Spotify client
- `voxtype-vulkan` — Voice-to-text
