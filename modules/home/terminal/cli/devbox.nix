{pkgs, ...}: {
  home.packages = with pkgs; [
    devbox
  ];
  programs = {
    zsh = {
      initContent = ''
        source <(devbox completion zsh); compdef _devbox devbox
      '';
    };
  };
}
