{ pkgs, username, ... }:

{
  imports = [
   (import ./pass.nix {inherit pkgs username;})
  ];
}