{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    # terminal = "screen-256color";
    shell = "${pkgs.zsh}/bin/zsh";
    keyMode = "vi";
    historyLimit = 100000;
    #Base index for windows and panes.
    extraConfig = builtins.readFile ./tmux.conf;

    #Configs for plugins
    #https://haseebmajid.dev/posts/2023-07-10-setting-up-tmux-with-nix-home-manager/
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = catppuccin;
        extraConfig = ''
          set -wg automatic-rename on   # rename window to reflect current program
          set -g renumber-windows on    # renumber windows when a window is closed
          # Make the status line pretty and add some modules
          set -g status-right-length 100
          set -g status-left-length 100
          set -g status-left ""
          set -g status-right ""

          #Catpuccin
          set -g @catppuccin_flavour 'mocha' # latte,frappe, macchiato or mocha

          ## Pane
          ## Window
          set -g @catppuccin_window_status_style "basic" # basic, rounded, slanted, custom, or none

          set -g @catppuccin_window_text " #W"
          set -g @catppuccin_window_number "#I"
          set -g @catppuccin_window_current_text " #W"
          set -g @catppuccin_window_current_number "#I"

          ## Status line
          set -ag status-right "#{E:@catppuccin_status_session}"
          set -ag status-right "#{E:@catppuccin_status_user}"
          set -ag status-right "#{E:@catppuccin_status_host}"

            #set -g @catppuccin_status_right_separator "█ "

            ###
            #set -g @catppuccin_window_default_fill "number"
            #set -g @catppuccin_window_default_text "#W"

            #set -g @catppuccin_window_current_fill "number"
            #set -g @catppuccin_window_current_text "#W"
            #set -g @catppuccin_window_right_separator "█ "

            #set -g @catppuccin_status_modules_right "session user host"
            #set -g @catppuccin_directory_text "#{pane_current_path}"
        '';
      }
      {
        plugin = resurrect;
        extraConfig = ''
          resurrect_dir="$HOME/.tmux/resurrect"
          set -g @resurrect-dir $resurrect_dir
          set -g @resurrect-hook-post-save-all "sed -i 's/--cmd lua.*--cmd set packpath/--cmd \"lua/g; s/--cmd set rtp.*\$/\"/' $resurrect_dir/last"
          set -g @resurrect-capture-pane-contents 'on'
          # for neovim
          set -g @resurrect-strategy-nvim 'session'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-boot 'on'
          set -g @continuum-save-interval '10'
        '';
      }
    ];
  };
}
