{ config, pkgs, ... }:
let
  #home-manager-desktop = import ./home-manager-desktop.nix {inherit pkgs;};
in {
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  imports = [
    (import ../../modules/services/gnome-keyring.nix)
    (import ../../modules/desktops)
  ];
}