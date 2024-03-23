{ config, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./kitty.nix
    #./wezterm.nix
  ];
}
