{  config, pkgs, defaultUser, ... }:
 
{
  # TODO please change the username & home direcotry to your own
  home-manager.users.${defaultUser} = {
    home.username = defaultUser;
    home.homeDirectory = "/home/${defaultUser}";
  };
}