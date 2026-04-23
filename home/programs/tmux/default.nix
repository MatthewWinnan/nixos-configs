#
# Tmux - Omarchy-inspired config
#
# Prefix: C-Space (C-b as backup)
# Splits: h (horizontal), v (vertical)
# Windows: Alt+1-9
# Sessions: Alt+Up/Down
#
{
  config,
  pkgs,
  ...
}:
let
  inherit (config.lib.stylix) colors;
in
{
  xdg.configFile."tmux/plugins/tmux-which-key/config.yaml".source = ./config.yaml;

  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    terminal = "tmux-256color";
    prefix = "C-c";
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 50000;
    mouse = true;
    keyMode = "vi";

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60'
        '';
      }
      {
        plugin = tmux-which-key;
        extraConfig = ''
          set -g @tmux-which-key-xdg-enable 1
        '';
      }
    ];

    extraConfig = ''
      # Source tmux-which-key init (plugin.sh.tmux builds it but doesn't always source it)
      if-shell "test -f ~/.local/share/tmux/plugins/tmux-which-key/init.tmux" \
        "source-file ~/.local/share/tmux/plugins/tmux-which-key/init.tmux"

      # Secondary prefix
      set -g prefix2 C-b
      bind C-Space send-prefix

      # True color support
      set -ag terminal-overrides ",*:RGB"

      # General settings
      set -g focus-events on
      set -g set-clipboard on
      set -g allow-passthrough on
      setw -g aggressive-resize on
      set -g detach-on-destroy off
      setw -g pane-base-index 1
      set -g renumber-windows on

      # Vi mode for copy
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send -X copy-selection-and-cancel

      # Pane Controls
      bind h split-window -v -c "#{pane_current_path}"
      bind v split-window -h -c "#{pane_current_path}"
      bind x kill-pane

      bind -n C-M-Left select-pane -L
      bind -n C-M-Right select-pane -R
      bind -n C-M-Up select-pane -U
      bind -n C-M-Down select-pane -D

      bind -n C-M-S-Left resize-pane -L 5
      bind -n C-M-S-Down resize-pane -D 5
      bind -n C-M-S-Up resize-pane -U 5
      bind -n C-M-S-Right resize-pane -R 5

      # Window navigation
      bind r command-prompt -I "#W" "rename-window -- '%%'"
      bind c new-window -c "#{pane_current_path}"
      bind k kill-window

      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9

      bind -n M-Left select-window -t -1
      bind -n M-Right select-window -t +1
      bind -n M-S-Left swap-window -t -1 \; select-window -t -1
      bind -n M-S-Right swap-window -t +1 \; select-window -t +1

      # Session controls
      bind R command-prompt -I "#S" "rename-session -- '%%'"
      bind C new-session -c "#{pane_current_path}"
      bind K kill-session
      bind P switch-client -p
      bind N switch-client -n

      bind -n M-Up switch-client -p
      bind -n M-Down switch-client -n

      # Status bar
      set -g status-position top
      set -g status-interval 5
      set -g status-left-length 30
      set -g status-right-length 50
      set -g window-status-separator ""
      setw -g automatic-rename on
      setw -g automatic-rename-format '#{b:pane_current_path}'

      # Theme (using Stylix colors)
      set -g status-style "bg=default,fg=default"
      set -g status-left "#[fg=#${colors.base00},bg=#${colors.base0D},bold] #S #[bg=default] "
      set -g status-right "#[fg=#${colors.base0D}]#{?pane_in_mode,COPY ,}#{?client_prefix,PREFIX ,}#{?window_zoomed_flag,ZOOM ,}#[fg=#${colors.base04}]#h "
      set -g window-status-format "#[fg=#${colors.base04}] #I:#W "
      set -g window-status-current-format "#[fg=#${colors.base0D},bold] #I:#W "
      set -g pane-border-style "fg=#${colors.base03}"
      set -g pane-active-border-style "fg=#${colors.base0D}"
      set -g message-style "bg=default,fg=#${colors.base0D}"
      set -g message-command-style "bg=default,fg=#${colors.base0D}"
      set -g mode-style "bg=#${colors.base0D},fg=#${colors.base00}"
      setw -g clock-mode-colour "#${colors.base0D}"
    '';
  };
}
