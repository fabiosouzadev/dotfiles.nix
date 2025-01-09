# NOTE: Alacritty - a cross-platform, GPU-accelerated terminal emulator
{
  config,
  pkgs,
  ...
}: {
  programs.alacritty = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.alacritty;
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
}
