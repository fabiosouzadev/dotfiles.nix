{
  config,
  pkgs,
  ...
}: {
  programs.wezterm = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.wezterm;
    enableZshIntegration = true;
    enableBashIntegration = true;
    extraConfig = builtins.readFile ./wezterm.lua;
  };
}
