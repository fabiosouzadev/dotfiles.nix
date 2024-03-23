{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
    ./spotify.nix
    ./terminals
  ];
}
