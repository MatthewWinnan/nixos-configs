# Nixvim Configuration

The Neovim configuration is fully declarative via [nixvim](https://github.com/nix-community/nixvim) and lives in `nix/applications/nixvim/`. It is enabled on every machine (including headless) and set as the default editor.

## Structure

```
nix/applications/nixvim/
├── default.nix       # Entry point — enables nixvim, sets colorscheme
├── opts.nix          # Vim options (line numbers, tabs, search, etc.)
├── keymaps.nix       # Global keybindings (leader = Space)
├── autocmds.nix      # Auto-commands (transparency, spellcheck, etc.)
└── plugins/
    ├── default.nix   # Imports all plugin categories
    ├── nix.nix       # Nix-specific support (hmts)
    ├── lsp/          # Language Server Protocol
    ├── completion/   # Auto-completion
    ├── treesitter/   # Syntax highlighting
    ├── snippets/     # Snippet engine
    ├── git/          # Git integration
    ├── ui/           # UI enhancements
    ├── utils/        # Utility plugins
    └── games/        # Fun plugins
```

## Colorscheme

Catppuccin Macchiato is the default colorscheme. Stylix's nixvim target is disabled to avoid conflicts — the theme is managed directly in the nixvim config.

## Options (`opts.nix`)

| Option | Value | Notes |
|--------|-------|-------|
| Relative line numbers | ✓ | With absolute number on current line |
| Mouse | Enabled (`a`) | Right-click extends selection |
| Tab width | 2 spaces | Expand tabs to spaces |
| Search | Incremental, case-smart | Ignorecase + smartcase |
| Scroll offset | 12 lines | Keeps cursor centered |
| Swap file | Disabled | |
| Undo file | Enabled | Persistent undo history |
| Split behavior | Below + right | |
| Clipboard | `unnamedplus` | System clipboard via wl-copy |
| Fold | Enabled (level 99) | Compatible with nvim-ufo |
| Conceallevel | 1 | For Obsidian.nvim compatibility |
| File encoding | UTF-8 | |
| Word wrap | Disabled | |

## Keymaps (`keymaps.nix`)

Leader key: `Space`

### Normal Mode

| Key | Action |
|-----|--------|
| `Esc` | Clear search highlights |
| `Y` | Yank to end of line (fix default) |
| `Ctrl+c` | Switch to alternate buffer |
| `Ctrl+x` | Close window |
| `Ctrl+s` | Save file |
| `Ctrl+↑/↓` | Resize window vertically |
| `Ctrl+←/→` | Resize window horizontally |
| `Alt+k` / `Alt+j` | Move current line up/down |

### Visual Mode

| Key | Action |
|-----|--------|
| `K` | Move selected block up |
| `J` | Move selected block down |

## Auto-Commands (`autocmds.nix`)

| Event | Action |
|-------|--------|
| VimEnter | Enable transparency |
| InsertEnter | Center cursor vertically |
| FileType help | Open help in vertical split |
| FileType tex/latex/markdown | Enable spellcheck (English) |

## Plugins

### LSP (`plugins/lsp/`)

| Plugin | Purpose |
|--------|---------|
| lsp | Core LSP client with profile-aware server selection |
| lsp-format | Auto-format on save |
| lspsaga | Enhanced LSP UI (code actions, rename, diagnostics) |
| lspkind | VSCode-like icons in completion |
| fidget | LSP progress indicator |
| trouble | Diagnostics list |
| conform | Formatter integration |
| none-ls | Additional linting/formatting sources |
| hlchunk | Indent/chunk highlighting |

#### LSP Servers

All profiles:
- `nil_ls` — Nix
- `html` — HTML
- `jsonls` — JSON
- `pyright` — Python
- `ruff` — Python linting
- `yamlls` — YAML
- `clangd` — C/C++
- `cmake` — CMake
- `rust_analyzer` — Rust (uses system rustc/cargo)
- `texlab` — LaTeX

Work profile adds:
- `dockerls` — Dockerfile
- `docker_compose_language_service` — Docker Compose
- `nginx_language_server` — Nginx

#### LSP Keymaps

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gD` | Go to declaration |
| `gI` | Go to implementation |
| `gT` | Type definition |
| `K` | Hover documentation |
| `<leader>cw` | Workspace symbol |
| `<leader>cr` | Rename |
| `<leader>cd` | Line diagnostics |
| `[d` / `]d` | Next/previous diagnostic |

### Completion (`plugins/completion/`)

| Plugin | Purpose |
|--------|---------|
| nvim-cmp | Auto-completion engine |
| SchemaStore | JSON/YAML schema support |

### Treesitter (`plugins/treesitter/`)

| Plugin | Purpose |
|--------|---------|
| treesitter | Syntax highlighting and parsing |
| treesitter-context | Sticky function/class context at top of buffer |

### Snippets (`plugins/snippets/`)

| Plugin | Purpose |
|--------|---------|
| LuaSnip | Snippet engine |

### Git (`plugins/git/`)

| Plugin | Purpose |
|--------|---------|
| gitsigns | Git gutter signs, blame, hunk navigation |
| lazygit | Lazygit integration inside Neovim |

### UI (`plugins/ui/`)

| Plugin | Purpose |
|--------|---------|
| alpha | Dashboard/start screen |
| lualine | Status line |
| staline | Alternative status line |
| noice | Enhanced UI for messages, cmdline, popups |
| nvim-notify | Notification popups |
| telescope | Fuzzy finder (files, grep, buffers, etc.) |
| neo-tree | File explorer sidebar |
| which-key | Keybinding hints |
| navic | Breadcrumb navigation |
| navbuddy | Symbol navigation |
| yazi | Yazi file manager integration |
| floaterm | Floating terminal |
| marks | Mark visualization |
| twilight | Dim inactive code (focus mode) |
| transparent | Background transparency |
| vimade | Fade inactive windows |
| precognition | Motion hints |
| auto-session | Session save/restore |
| image | Image preview in terminal |

### Utils (`plugins/utils/`)

| Plugin | Purpose |
|--------|---------|
| oil | File editing as a buffer |
| harpoon | Quick file navigation |
| flash | Enhanced motions (jump to any character) |
| spectre | Project-wide search and replace |
| muren | Multi-pattern search and replace |
| undotree | Undo history visualization |
| multicursors | Multiple cursor editing |
| autopairs | Auto-close brackets/quotes |
| comment | Toggle comments |
| comment-box | Decorated comment boxes |
| neoclip | Clipboard/yank history |
| snipe | Quick buffer/window jumping |
| mini | Collection of mini plugins |
| ufo | Modern fold management |
| colorizer | Color code highlighting |
| illuminate | Highlight word under cursor |
| render-markdown | Markdown rendering |
| markview | Markdown preview |
| web-devicons | File type icons |
| vim-bbye | Better buffer deletion |
| texpresso | Live LaTeX preview |
| transparent | Transparency toggle |

### Games (`plugins/games/`)

| Plugin | Purpose |
|--------|---------|
| cellular-automation | Cellular automaton animations |
| duckytype | Typing speed test |
| vim-be-good | Vim motion practice game |
