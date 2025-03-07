{
  config,
  lib,
  pkgs,
  vars,
  ...
}: {
  # TODO please change the username & home directory to your own
  home.username = vars.username;
  home.homeDirectory = pkgs.lib.mkDefault "/home/${vars.username}";

  imports =
    [
      ./common.nix
      ./xdg.nix
      ../browsers
      ../editors
      ../terminal/emulators
      ../terminal/shells
      ../terminal/cli
      ../terminal/tui
      ../cloud
    ]
    ++ (lib.optionals (vars.desktop == "xfce" && vars.wm == "i3") [../wm/i3]);

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = vars.stateVersion;

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
