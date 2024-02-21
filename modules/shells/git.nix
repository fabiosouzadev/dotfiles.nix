{  config, pkgs, defaultUser, defaultGit, ... }:

{
  # basic configuration of git, please change to your own
  home-manager.users.${defaultUser} = {
    programs.git = {
      enable = true;
      userName = defaultGit.userName;
      userEmail = defaultGit.userEmail;
    };
   };
}
