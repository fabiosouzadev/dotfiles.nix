{...}: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };
  xdg.configFile."yazi/theme.toml".source = ./catppuccin-mocha.toml;
}
