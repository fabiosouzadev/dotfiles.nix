{ pkgs, ... }:

{
  imports = [
    ./common.nix
    ./spotify.nix
    ./terminals
    ./editors.nix
  ];
}
