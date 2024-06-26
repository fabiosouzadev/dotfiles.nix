{pkgs, ...}: let
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
  tmux-fzf-session-switch = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-fzf-session-switch";
    version = "latest";
    src = pkgs.fetchFromGitHub {
      owner = "thuanOwa";
      repo = "tmux-fzf-session-switch";
      rev = "5d18ec0558a147392a0d66991eb9411dbdbc3ce";
      sha256 = "sha256-fQbrw42dAHVEDAyuZd26w6hvjEhqQMSpAcxSMvs1aHw=";
    };
  };
in {
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    shell = "${pkgs.zsh}/bin/zsh";
    keyMode = "vi";
    historyLimit = 10000;
    #Base index for windows and panes.
    baseIndex = 1;
    extraConfig = ''
      ### : << eof
      ### https://github.com/fabiosouzadev/dotfiles
      ###

      ### INSTALLATION NOTES ###:
      # Usage:
      # - Prefix is set to Ctrl-b (make sure you remapped Caps Lock to Ctrl)
      # - All prefixed with Ctrl-b
      # - PANES
      #   - Vertical split:   Prefix + v
      #   - Horizontal split: Prefix + x
      #   - Close pane:
      #   - Zoom pane:       Prefix-+ or Prefix-z
      #   - Swap pane:       Prefix + > # swap current pane with the next one
      #   - Swap pane:       Prefix + < # swap current pane with the previous one
      #   - H to V:          Prefix + Space # Move Tmux Pane from Vertical to Horizontal
      #   - Move to left:    Prefix + {
      #   - Move to right:   Prefix + }
      # - WINDOW
      #   - New window:       Prefix + c
      #   - Rename window:    Prefix + r
      #   - Next window:      Prefix + n or Prefix + Ctrl-l
      #   - Previous window:  Prefix + p or Prefix + Ctrl+h
      #   - Last used window: Prefix + Tab
      #   - Quick window:     Prefix + w
      #   - Close window:     Prefix + &
      # - SESSION
      #   - New session       Prefix + Ctrl+c
      #   - Rename session    Prefix + Ctrl+r
      #   - Fzf session       Prefix + Ctrl-f
      # - CONFIG
      #   - Reload Config     Prefix + i
      # - COPY-MODE-VI
      #   - copy-vi-mode                  Prefix-Enter
      #   - begin-selection               v
      #   - toggle blockwise v mode       Ctrl-v
      #   - jumps start line              H
      #   - jumps end line                L
      #   - Cancel                        Escape

      #   https://github.com/samoshkin/tmux-config/blob/master/tmux/tmux.conf # Inspired by
      #   https://gist.github.com/v-yarotsky/2157908 # Inspired by
      #   https://awesomeopensource.com/project/samoshkin/tmux-config#key-bindings
      #   https://github.com/gpakosz/.tmux

      # ==========================
      # ===  General settings  ===
      # ==========================

      #set -g default-terminal 'tmux-256color'
      set-option -ga terminal-overrides ",*256col*:Tc:RGB"
      set-option -a terminal-overrides ",alacritty:Tc:RGB"
      # set-option -g default-shell /bin/zsh
      set -g buffer-limit 20
      set -sg escape-time 10
      set -g repeat-time 600
      set -s focus-events on
      set -g display-time 1000
      set -g display-panes-time 800
      set -g remain-on-exit off
      setw -g aggressive-resize on
      set -g mouse off
      set-option -g status-position top


      setw -g automatic-rename on   # rename window to reflect current program
      set -g renumber-windows on    # renumber windows when a window is closed

      # Start index of window/pane with 1, because we're humans, not computers
      set -g base-index 1
      setw -g pane-base-index 1

      # Set parent terminal title to reflect current window in tmux session
      set -g set-titles on
      set -g set-titles-string "#T - #I:#W"

      set -g renumber-windows on
      set -g status-interval 10       # redraw status line every 10 seconds
      setw -g xterm-keys on
      set -q -g status-utf8 on        # expect UTF-8 (tmux < 2.2)
      setw -q -g utf8 on

      # Enable mouse support
      #set -g mouse on

      # activity
      set -g monitor-activity on
      set -g visual-activity off

      # ==========================
      # ===   Key bindings     ===
      # ==========================

      # Change prefix key to C-a, easier to type, same to "screen"
      #unbind C-b
      #set -g prefix C-a

      # Unbind default key bindings, we're going to override
      unbind %         # split-window -h
      unbind '"'       # split-window
      unbind "\$"      # rename-session
      unbind ,         # rename-window
      unbind M-Up      # resize 5 rows up
      unbind M-Down    # resize 5 rows down
      unbind M-Right   # resize 5 rows right
      unbind M-Left    # resize 5 rows left
      unbind p         # select previous window
      unbind l         # last last-window
      unbind n         # select next window


      # Session
      bind C-c new-session
      bind C-r command-prompt -I "#{session_name}" "rename-session '%%'"
      bind C-f command-prompt -p find-session 'switch-client -t %%'

      # Panes
      bind v split-window -h -c "#{pane_current_path}"
      bind x split-window -v -c "#{pane_current_path}"
      bind > swap-pane -D       # swap current pane with the next one
      bind < swap-pane -U       # swap current pane with the previous one
      bind '"' kill-pane

      # pane resizing
      bind + resize-pane -Z       # Zoom pane
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # Window
      bind c new-window
      bind r command-prompt -I "#{window_name}" "rename-window '%%'"
      # bind -r p previous-window   # select previous window
      bind -r n next-window       # select next window
      bind -r l last-window       # move to last active window
      bind Tab last-window        # move to last active window
      bind -r C-h select-window -t :-   # Jump to window on the left
      bind -r C-l select-window -t :+   # Jump to window on the right

      # Edit configuration and reload
      #bind C-e new-window -n 'tmux.conf' "sh -c '\${EDITOR:-vim} ~/.tmux.conf && tmux source ~/.tmux.conf && tmux display \"Config reloaded\"'"
      bind i source-file ~/.config/tmux/tmux.conf \; display "Config reloaded"  # Reload tmux configuration


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



      #https://github.com/aserowy/tmux.nvim
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'

      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R
      # bind-key -T copy-mode-vi 'C-\' select-pane -l
      # bind-key -T copy-mode-vi 'C-Space'  select-pane -t:.+

      # ==================================================
      # ===                   Buffer                  ===
      # ==================================================
      bind b list-buffers     # list paste buffers
      bind p paste-buffer -p  # paste from the top paste buffer
      bind P choose-buffer    # choose which buffer to paste from

      # ==================================================
      # === Window monitoring for activity and silence ===
      # ==================================================

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

      # =====================================
      # ===        Renew environment      ===
      # =====================================
      set -g update-environment \
        "DISPLAY\
        SSH_ASKPASS\
        SSH_AUTH_SOCK\
        SSH_AGENT_PID\
        SSH_CONNECTION\
        SSH_TTY\
        WINDOWID\
        XAUTHORITY"

      # bind '$' run "~/.tmux/renew_env.sh"

      #source ~/.config/tmux/tokyonight.conf
      #source ~/.config/tmux/utility.conf

      # ==============================================
      # ===   Nesting local and remote sessions     ===
      # ==============================================

      #Session
      set -g @resurrect-save 'S'
      set -g @resurrect-restore 'R'
      set -g @resurrect-capture-pane-contents 'on'
      set -g @resurrect-processes '~nvim ~vim'

      set -g @continuum-restore 'on'

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

      #olimorris/tmux-pomodoro-plus
      set -g @pomodoro_on "🍅 "
      set -g @pomodoro_complete "✅ "
      set -g @pomodoro_notifications 'on'        # Enable desktop notifications from your terminal
      set -g @pomodoro_sound 'on'                # Sound for desktop notifications (Run `ls /System/Library/Sounds` for a list of sounds to use on Mac)

      # Display lazygit
      bind -r g display-popup -d '#{pane_current_path}' -w80% -h80% -E lazygit
      bind -r o display-popup -d '#{pane_current_path}' -w80% -h80% -E lazydocker

      # ============================
      # ===       Plugins        ===
      # ============================
      #set -g @plugin 'tmux-plugins/tpm'  #prefix + I (Install), prefix + U (update), prefix + alt + U (remove)
      #set -g @plugin 'olimorris/tmux-pomodoro-plus'
      #set -g @plugin 'tmux-plugins/tmux-prefix-highlight'
      #set -g @plugin 'tmux-plugins/tmux-yank'
      #set -g @plugin 'thuanOwa/tmux-fzf-session-switch' # Prefix + Ctrl-f
      #set -g @plugin 'aserowy/tmux.nvim'
      run-shell ${tmux-fzf-session-switch}/share/tmux-plugins/tmux-fzf-session-switch/main.tmux
      run-shell ${tmux-prefix-highlight}/share/tmux-plugins/prefix-highlight/prefix_highlight.tmux
      run-shell ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/resurrect.tmux
      run-shell ${pkgs.tmuxPlugins.continuum}/share/tmux-plugins/continuum/continuum.tmux
      run-shell ${pkgs.tmuxPlugins.yank}/share/tmux-plugins/yank/yank.tmux
      run-shell ${pkgs.tmuxPlugins.vim-tmux-navigator}/share/tmux-plugins/vim-tmux-navigator/vim-tmux-navigator.tmux

    '';
    plugins = with pkgs; [
      tmuxPlugins.resurrect
      tmuxPlugins.continuum
      tmuxPlugins.yank
      tmux-fzf-session-switch
      tmux-prefix-highlight
      tmuxPlugins.vim-tmux-navigator
    ];
  };
}
