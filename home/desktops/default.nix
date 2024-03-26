{ pkgs, ... }:

{
  imports = [
    ./common.nix
    ./browsers.nix
    ./spotify.nix
    ./terminals
  ];
}
