{pkgs, ...}: {
  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      nix-direnv = {
        enable = true;
      };
    };
    zsh = {
      initContent = ''
        source <(devbox completion zsh); compdef _devbox devbox
      '';
      shellAliases = {
        "direnv-install" = "echo \"use flake\" > .envrc && ${pkgs.direnv}/bin/direnv allow";
      };
    };
  };
}
