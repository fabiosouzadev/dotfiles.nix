{pkgs, ...}: {
  home.packages = with pkgs; [devenv];

  programs.zsh = {
    shellAliases = {
      devclean = "devenv gc && rm -rf .direnv .devenv && nix store gc && rm -rf /run/user/1000/devenv-* && rm -f devenv.lock";
    };
  };
}
