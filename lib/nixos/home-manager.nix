{ isDesktop }: { pkgs, ... }:
{

  imports = [
    ../../home/services/gnome-keyring.nix
    ../../home/desktops
  ];
}