{ pkgs, ...}:
let
   tmux-prefix-highlight = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "prefix-highlight";
    version = "latest";
    src = pkgs.fetchFromGitHub {
      owner = "tmux-plugins";
      repo = "tmux-prefix-highlight";
      rev = "489a96189778a21d2f5f4dbbbc0ad2cec8f6c854";
      sha256 = "sha256-GXqlwl1TPgXX1Je/ORjGFwfCyz17ZgdsoyOK1P3XF18=";
    };
  };
in
{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    shell = "${pkgs.zsh}/bin/zsh";
    keyMode = "vi";
    historyLimit = 100000;
    #Base index for windows and panes.
    extraConfig = 
    ''
    # ==========================
    # ===  General settings  ===
    # ==========================
    #set -g default-terminal 'tmux-256color'
    set-option -ga terminal-overrides ",*256col*:Tc:RGB"
    set-option -a terminal-overrides ",alacritty:Tc:RGB"

    setw -g automatic-rename on   # rename window to reflect current program
    set -g renumber-windows on    # renumber windows when a window is closed
    
    # ==========================
    # ===   Key bindings     ===
    # ==========================

    # Smart pane switching with awareness of Vim splits.
    # See: https://github.com/christoomey/vim-tmux-navigator
    is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
        | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
    bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
    bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
    bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
    bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
    tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
    if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
        "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
    if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
        "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

    bind-key -T copy-mode-vi 'C-h' select-pane -L
    bind-key -T copy-mode-vi 'C-j' select-pane -D
    bind-key -T copy-mode-vi 'C-k' select-pane -U
    bind-key -T copy-mode-vi 'C-l' select-pane -R
    bind-key -T copy-mode-vi 'C-\' select-pane -l

    # ================================================
    # ===     Copy mode, scroll and clipboard      ===
    # ================================================

    bind Enter copy-mode # enter copy mode

    run -b 'tmux bind -t vi-copy v begin-selection 2> /dev/null || true'
    run -b 'tmux bind -T copy-mode-vi v send -X begin-selection 2> /dev/null || true'
    run -b 'tmux bind -t vi-copy C-v rectangle-toggle 2> /dev/null || true'
    run -b 'tmux bind -T copy-mode-vi C-v send -X rectangle-toggle 2> /dev/null || true'
    run -b 'tmux bind -t vi-copy y copy-selection 2> /dev/null || true'
    run -b 'tmux bind -T copy-mode-vi y send -X copy-selection-and-cancel 2> /dev/null || true'
    run -b 'tmux bind -t vi-copy Escape cancel 2> /dev/null || true'
    run -b 'tmux bind -T copy-mode-vi Escape send -X cancel 2> /dev/null || true'
    run -b 'tmux bind -t vi-copy H start-of-line 2> /dev/null || true'
    run -b 'tmux bind -T copy-mode-vi H send -X start-of-line 2> /dev/null || true'
    run -b 'tmux bind -t vi-copy L end-of-line 2> /dev/null || true'
    run -b 'tmux bind -T copy-mode-vi L send -X end-of-line 2> /dev/null || true'

    # copy to X11 clipboard
    if -b 'command -v xsel > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | xsel -i -b"'
    if -b '! command -v xsel > /dev/null 2>&1 && command -v xclip > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | xclip -i -selection clipboard >/dev/null 2>&1"'
    # copy to Wayland clipboard
    if -b 'command -v wl-copy > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | wl-copy"'
    # copy to macOS clipboard
    if -b 'command -v pbcopy > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | pbcopy"'
    if -b 'command -v reattach-to-user-namespace > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | reattach-to-user-namespace pbcopy"'
    # copy to Windows clipboard
    if -b 'command -v clip.exe > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | clip.exe"'
    if -b '[ -c /dev/clipboard ]' 'bind y run -b "tmux save-buffer - > /dev/clipboard"'


    # ==============================================
    # ===                 Theme                  ===
    # ==============================================
    # TokyoNight colors for Tmux
    set -g mode-style "fg=#7aa2f7,bg=#3b4261"

    set -g message-style "fg=#7aa2f7,bg=#3b4261"
    set -g message-command-style "fg=#7aa2f7,bg=#3b4261"

    set -g pane-border-style "fg=#3b4261"
    set -g pane-active-border-style "fg=#7aa2f7"

    set -g status "on"
    set -g status-justify "left"

    set -g status-style "fg=#7aa2f7,bg=#1f2335"

    set -g status-left-length "100"
    set -g status-right-length "100"

    set -g status-left-style NONE
    set -g status-right-style NONE

    set -g status-left "#[fg=#1d202f,bg=#7aa2f7,bold] #S #[fg=#7aa2f7,bg=#1f2335,nobold,nounderscore,noitalics]"
    set -g status-right "#[fg=#1f2335,bg=#1f2335,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#1f2335] #{prefix_highlight} #[fg=#3b4261,bg=#1f2335,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261] #{pomodoro_status} %Y-%m-%d  %I:%M %p #[fg=#7aa2f7,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#1d202f,bg=#7aa2f7,bold] #h "

    setw -g window-status-activity-style "underscore,fg=#a9b1d6,bg=#1f2335"
    setw -g window-status-separator ""
    setw -g window-status-style "NONE,fg=#a9b1d6,bg=#1f2335"
    setw -g window-status-format "#[fg=#1f2335,bg=#1f2335,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#1f2335,bg=#1f2335,nobold,nounderscore,noitalics]"
    setw -g window-status-current-format "#[fg=#1f2335,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261,bold] #I  #W #F #[fg=#3b4261,bg=#1f2335,nobold,nounderscore,noitalics]"

    # ============================
    # ===       Plugins        ===
    # ============================
    run-shell ${tmux-prefix-highlight}/share/tmux-plugins/prefix-highlight/prefix_highlight.tmux
    run-shell ${pkgs.tmuxPlugins.vim-tmux-navigator}/share/tmux-plugins/vim-tmux-navigator/vim-tmux-navigator.tmux
    run-shell ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/resurrect.tmux
    run-shell ${pkgs.tmuxPlugins.continuum}/share/tmux-plugins/continuum/continuum.tmux
    run-shell ${pkgs.tmuxPlugins.yank}/share/tmux-plugins/yank/yank.tmux

    # tmux-plugins/tmux-prefix-highlight support
    set -g @prefix_highlight_show_copy_mode 'on'
    set -g @prefix_highlight_copy_mode_attr 'fg=black,bg=yellow,bold' # default is 'fg=default,bg=yellow'
    set -g @prefix_highlight_show_sync_mode 'on'
    set -g @prefix_highlight_sync_mode_attr 'fg=black,bg=green' # default is 'fg=default,bg=yellow'
    set -g @prefix_highlight_prefix_prompt ' WAIT '
    set -g @prefix_highlight_copy_prompt ' COPY '
    set -g @prefix_highlight_sync_prompt ' SYNC '
    set -g @prefix_highlight_output_prefix "#[fg=#e0af68]#[bg=#1f2335]#[fg=#1f2335]#[bg=#e0af68]"
    set -g @prefix_highlight_output_suffix ""

    # ==============================================
    # ===           Remote sessions              ===
    # ==============================================

    #Session
    set -g @resurrect-save 'S'
    set -g @resurrect-restore 'R'
    set -g @resurrect-capture-pane-contents 'on'
    set -g @resurrect-processes '~nvim ~vim'

    set -g @continuum-restore 'on'

    # ==============================================
    # ===                 Popup                  ===
    # ==============================================  
    # Display lazygit
    bind -r g display-popup -d '#{pane_current_path}' -w80% -h80% -E lazygit
    bind -r o display-popup -d '#{pane_current_path}' -w80% -h80% -E lazydocker
    bind -r k display-popup -d '#{pane_current_path}' -w80% -h80% -E k9s

    '';
    plugins = with pkgs; [
      tmux-prefix-highlight
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.resurrect
      tmuxPlugins.continuum
      tmuxPlugins.yank
    ];
   };
}
