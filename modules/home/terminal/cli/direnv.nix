{pkgs, ...}: {
  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
      nix-direnv = {
        enable = true;
      };
    };
    zsh = {
      initExtra = ''
        source <(devbox completion zsh); compdef _devbox devbox
      '';
      shellAliases = {
        "direnv-install" = "echo \"use flake\" > .envrc && ${pkgs.direnv}/bin/direnv allow";
      };
    };
  };
}
