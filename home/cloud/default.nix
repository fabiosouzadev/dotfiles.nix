{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
    #./aws.nix
    ./gcp.nix
  ];
}
