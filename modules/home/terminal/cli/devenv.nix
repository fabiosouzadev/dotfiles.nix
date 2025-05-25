{pkgs, ...}: {
  home.packages = with pkgs; [devenv];

  programs.zsh = {
    shellAliases = {
      devc = "devenv gc && rm -rf .direnv .devenv && rm -f devenv.lock && rm -rf /run/user/1000/devenv-* ";
      devnc = "nix store gc";
    };
  };
}
