
{  config, pkgs, ... }:
 
{
  programs.kitty = {
    enable = true;

    font = {
      name = "IosevkaTerm NF";
      package = pkgs.kitty;
      size = 12;
    };

    settings = {
      scrollback_lines = 10000;
      wheel_scroll_min_lines = 1;
      window_padding_width = 0;
      confirm_os_window_close = 0;
      background_opacity = "0.85";
      macos_option_as_alt = true; # Option key acts as Alt on macOS
      enable_audio_bell = false;
      shell = "${pkgs.zsh}/bin/zsh";
    };

      extraConfig = ''
## name: Tokyo Night Moon
## license: MIT
## author: Folke Lemaitre
## upstream: https://github.com/folke/tokyonight.nvim/raw/main/extras/kitty/tokyonight_moon.conf


background #222436
foreground #c8d3f5
selection_background #3654a7
selection_foreground #c8d3f5
url_color #4fd6be
cursor #c8d3f5
cursor_text_color #222436

# Tabs
active_tab_background #82aaff
active_tab_foreground #1e2030
inactive_tab_background #2f334d
inactive_tab_foreground #545c7e
#tab_bar_background #1b1d2b

# Windows
active_border_color #82aaff
inactive_border_color #2f334d

# normal
color0 #1b1d2b
color1 #ff757f
color2 #c3e88d
color3 #ffc777
color4 #82aaff
color5 #c099ff
color6 #86e1fc
color7 #828bb8

# bright
color8 #444a73
color9 #ff757f
color10 #c3e88d
color11 #ffc777
color12 #82aaff
color13 #c099ff
color14 #86e1fc
color15 #c8d3f5

# extended colors
color16 #ff966c
color17 #c53b53
      '';

    };
}
