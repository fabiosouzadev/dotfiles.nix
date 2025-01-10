{ pkgs, ... }:

{
  imports = [
    # ../shared/laptop.nix
    ../shared/bluetooth.nix
    ../shared/hardware-acceleration.nix
    ../shared/pulseaudio.nix
  ];
}
