{lib, ...}: {
  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
    extraConfig = lib.strings.concatStringsSep "\n" [(builtins.readFile ./kitty.conf) (builtins.readFile ./catppuccin-mocha.conf)];
  };
}
