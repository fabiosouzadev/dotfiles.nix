{ config, pkgs, ... }:
{
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  imports = [
    ../../modules/virtualisation
  ];
}