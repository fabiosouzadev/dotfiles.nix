{  config, pkgs, defaultUser, defaultGit, ... }:

{
  # basic configuration of git, please change to your own
  home-manager.users.${defaultUser} = {
    programs.bat = {
     enable = true;
     config = {theme = "catppuccin";};
     themes = {
       catppuccin = {
         src =
           pkgs.fetchFromGitHub
           {
             owner = "catppuccin";
             repo = "bat";
             rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
             sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
           };
         file = "Catppuccin-macchiato.tmTheme";
       };
     };
   };

    programs.zsh = {
     shellAliases = {
	"cat" = "${pkgs.bat}/bin/bat";
      };
    };
  };
}
