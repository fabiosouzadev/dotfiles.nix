{  config, pkgs, ... }:
 
{
  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Fabio Souza";
    userEmail = "fabiovanderlei.developer@gmail.com";
  };
}