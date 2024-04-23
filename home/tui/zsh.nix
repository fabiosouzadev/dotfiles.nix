{...}: {
  # basic configuration of git, please change to your own
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    history = {
      save = 10000000;
      size = 10000000;
      share = true;
    };
    # initExtra = ''
    #  source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    # '';
    #shellAliases = {
    #};
  };
}
