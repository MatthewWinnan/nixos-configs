# Theming

System-wide theming is managed through Stylix with Catppuccin Macchiato as the color palette.

## Stylix

Config: `themes/stylix.nix`

- Generates colors automatically from the per-machine wallpaper (`config.images.stylix_wallpaper`)
- Polarity: dark
- Opacity: terminal at 0.8, everything else at 1.0 (popups forced to 1.0 to fix transparent context menus)
- Nixvim target disabled — colorscheme managed directly in nixvim config
- Home-level overrides in `home/desktop/stylix.nix`

## Fonts

Config: `themes/fonts.nix`

| Font | Purpose |
|------|---------|
| JetBrains Mono | Primary monospace |
| Noto Fonts | System sans-serif |
| Noto Color Emoji | Emoji |
| Twemoji Color Font | Emoji (alt) |
| Font Awesome | Icons |
| Powerline Fonts/Symbols | Shell prompt |
| Nerd Fonts (0xProto, JetBrains Mono, Hack) | Terminal icons |

## Per-Machine Wallpapers

Each machine has a wallpaper definition in `image_store/<hostname>.nix` that sets `config.images.stylix_wallpaper`. Stylix derives the system color palette from this image.

## Cursor

- Hyprcursor with Rose Pine theme (`rose-pine-hyprcursor` flake input)
- `HYPRCURSOR_THEME = "rose-pine-hyprcursor"` set in environment variables
- Cursor size: 24

## GTK & Icons

- GTK theme: managed by Stylix (`themes/gtk.nix`)
- Icon themes: `themes/icon-themes.nix`
- LibreOffice overridden to use Adwaita GTK theme (bypasses Stylix)

## Waybar Themes

Selectable per-machine via `userSettings.waybar`:

| Theme | Machines Using It |
|-------|-------------------|
| `catppuccin` | od1n (default) |
| `gruvbox` | ba1dr |
| `omarchy` | h31mda11, fafn1r |
| `elifouts` | Available but unused |

Theme styles and settings are in `home/desktop/waybar/style/` and `home/desktop/waybar/settings/`.
