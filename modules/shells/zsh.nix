
{  config, pkgs, defaultUser, defaultGit, ... }:

{
  # basic configuration of git, please change to your own
  environment.shells = [ pkgs.zsh ];
  users.users.${defaultUser}.shell = pkgs.zsh;
  programs.zsh.enable = true;
  home-manager.users.${defaultUser} = {
    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      history = {
        save = 100000;
        size = 100000;
        share = true;
      };
      #initExtra = ''
      # export GPG_TTY= "$(tty)"
      #'';
      #shellAliases = {
      #};
   };
 };  
}
