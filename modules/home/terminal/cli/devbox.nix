{pkgs, ...}: {
  home.packages = with pkgs; [
    devbox
  ];
  programs = {
    zsh = {
      initExtra = ''
        source <(devbox completion zsh); compdef _devbox devbox
      '';
    };
  };
}
