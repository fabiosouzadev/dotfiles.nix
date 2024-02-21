{ config,pkgs, defaultUser, ... }: { 
  environment.shells = [ pkgs.zsh ];
  users.users.${defaultUser}.shell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    histSize = 100000;
  };
}
