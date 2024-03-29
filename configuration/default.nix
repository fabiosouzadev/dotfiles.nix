{ lib, pkgs, username, isDesktop, hasVirtualisation, ... }:
{
  imports = [
    ./user.nix
    ./nix.nix
    ./system-packages.nix
    ./localization.nix
    ./keymap.nix
    ../modules/fonts.nix
    ../modules/i3.nix
    ../modules/jetbrains.nix
    ../modules/polkit.nix
    ../modules/vscodium.nix
  ] ++ lib.optionals hasVirtualisation  [ ./virtualisation ];
}
