{  config, pkgs, defaultUser, defaultGit, ... }:

{
  # basic configuration of git, please change to your own
  home-manager.users.${defaultUser} = {
    programs.git = {
      enable = true;
      userName = defaultGit.userName;
      userEmail = defaultGit.userEmail;
      signing = {
      	key = "5884A73AFE6C0B1E5168B2DA9D79F9FD64781516";
      	signByDefault = true;
      };
    };
   };
}
