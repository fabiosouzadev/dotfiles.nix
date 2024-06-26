{ pkgs, isDesktop, ... }:
{

  imports = [
    ../../home/services/gnome-keyring.nix
    ../../home/desktops
  ];
}

