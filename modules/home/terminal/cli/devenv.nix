{pkgs, ...}: {
  home.packages = with pkgs; [devenv];

  programs.zsh = {
    shellAliases = {
      devc = "devenv gc && rm -rf .direnv .devenv && rm -rf /run/user/1000/devenv-* && rm -f devenv.lock";
      devnc = "nix store gc";
    };
  };
}
