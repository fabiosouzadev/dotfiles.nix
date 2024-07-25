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
          set -g @catppuccin_flavour 'mocha' # latte,frappe, macchiato or mocha

          set -g @catppuccin_window_default_fill "number"
          set -g @catppuccin_window_default_text "#W"

          set -g @catppuccin_window_current_fill "number"
          set -g @catppuccin_window_current_text "#W"
          set -g @catppuccin_window_right_separator "█ "

          set -g @catppuccin_status_modules_right "directory session user host"
          set -g @catppuccin_directory_text "#{pane_current_path}"
        '';
      }
      # {
      #   plugin = resurrect;
      #   extraConfig = ''
      #     set -g @resurrect-strategy-vim 'session'
      #     set -g @resurrect-strategy-nvim 'session'
      #     set -g @resurrect-capture-pane-contents 'on'
      #   '';
      # }
      # {
      #   plugin = continuum;
      #   extraConfig = ''
      #     set -g @continuum-restore 'on'
      #     set -g @continuum-boot 'on'
      #     set -g @continuum-save-interval '10'
      #   '';
      # }
    ];
  };
}
