{
  lib,
  config,
  pkgs,
  ...
}: {
  programs.kitty = {
    enable = true;
    # shows wrapping a package which requires nixGL and setting config options for it
    package = config.lib.nixGL.wrap pkgs.kitty;
    shellIntegration = {
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
    extraConfig = lib.strings.concatStringsSep "\n" [(builtins.readFile ./kitty.conf) (builtins.readFile ./rose-pine-moon.conf)];
  };
}
