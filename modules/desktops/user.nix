{  config, pkgs, username, ... }:
 
{
  # TODO please change the username & home direcotry to your own
  home.username = username;
  home.homeDirectory = "/home/${username}";

}