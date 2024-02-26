
{  config, pkgs, defaultUser, defaultGit, ... }:

{
  environment.systemPackages = with pkgs; [ 
   php
   php83Packages.composer
  ];  
}
