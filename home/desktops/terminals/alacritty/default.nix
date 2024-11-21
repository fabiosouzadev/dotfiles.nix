{lib, ...}: {
  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    settings = lib.strings.concatStringsSep "\n" [(builtins.readFile ./alacritty.conf) (builtins.readFile ./tokyo-night.toml)];
  };
}
