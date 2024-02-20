{  config, pkgs, defaultUser, ... }:
 
{
  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  home-manager.users.${defaultUser} = {
    programs.alacritty = {
      enable = true;
      # custom settings
      settings = {
        env.TERM = "xterm-256color";
        font = {
          size = 12;
        };
        scrolling.multiplier = 5;
        selection.save_to_clipboard = true;
      };
    };
  };
}
