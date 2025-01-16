{
  pkgs,
  username,
  stateVersion,
  ...
}: {
  # TODO please change the username & home directory to your own
  home.username = username;
  home.homeDirectory = pkgs.lib.mkDefault "/home/${username}";

  imports = [
    ../../modules/browsers
    ../../modules/editors
    ../../modules/terminal/emulators
    ../../modules/terminal/shells
    ../../modules/terminal/cli
    ../../modules/terminal/tui
    ../../modules/de/i3
    ../../modules/cloud
    ../../modules/shared/common.nix
  ];

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = stateVersion;

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
