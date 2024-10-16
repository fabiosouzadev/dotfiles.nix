{
  pkgs,
  username,
  config,
  ...
}: let
  defaultGit = {
    extraConfig.github.user = username;
    userEmail = "fabiovanderlei.developer@gmail.com";
    userName = "Fabio Souza";
  };
in {
  home.packages = with pkgs; [
    lazygit
    gh #github
  ];
  programs.git = {
    enable = true;

    userName = defaultGit.userName;
    userEmail = defaultGit.userEmail;

    signing = {
      key = "64781516";
      signByDefault = true;
    };

    delta = {
      enable = true;
      options = {
        navigate = true;
        light = false;
        line-numbers = true;
        minus-style = "syntax #3a273a";
        minus-non-emph-style = "syntax #3a273a";
        minus-emph-style = "syntax #6b2e43";
        minus-empty-line-marker-style = "syntax #3a273a";
        line-numbers-minus-style = "#b55a67";
        plus-style = "syntax #273849";
        plus-non-emph-style = "syntax #273849";
        plus-emph-style = "syntax #305f6f";
        plus-empty-line-marker-style = "syntax #273849";
        line-numbers-plus-style = "#627259";
        line-numbers-zero-style = "#3b4261";
      };
    };

    aliases = {
      a = "!git add --all";
      amend = "!git add --all && git commit --amend --no-edit";
      c = "!git add --all && git commit -sm";
      ci = "!git commit";
      co = "!git checkout";
      d = "!git diff";
      dc = "!git diff --cached";
      l = "!git log --pretty=format:'%C(blue)%hC(red)%d %C(white)%s - %C(cyan)%cn, %C(green)%cr'";
      pl = "!git pull";
      ps = "!git push";
      s = "!git status -s";
      st = "!git status";
    };

    extraConfig = {
      color.ui = true;
      fetch.prune = true;
      pull.rebase = true;
      push.autoSetupRemote = true;
      rebase.autoStash = true;
      credential.helper = "cache --timeout=28800";
      core = {
        editor = "nvim";
        default = "current";
      };
      init.defaultBranch = "main";
      diff.colorMoved = "default";
      merge = {
        tool = "nvim";
        conflictstyle = "diff3";
      };
      mergetool.keepBackup = false;
      "mergetool \"nvim\"".cmd = "nvim -d $LOCAL $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'";
    };

    ignores = [".direnv" ".DS_Store"];
  };

  programs.zsh = {
    shellAliases = {
      gitgrep = "git ls-files | rg";
    };
    initExtra = ''
      ghpr() {
        GH_FORCE_TTY="100%" \
        gh pr list | \
          fzf --ansi \
            --preview 'GH_FORCE_TTY="100%" gh pr view {1}' \
            --preview-window down  --header-lines 3 | \
          awk '{print $1}' | \
          xargs gh pr checkout
      }

      ghprtx() {
        GH_FORCE_TTY="100%"
        gh pr list | \
          fzf-tmux -p90%,90% --ansi \
            --preview 'GH_FORCE_TTY="100%" gh pr view {1}' \
            --preview-window down  --header-lines 3 \
            --bind "ctrl-k:preview-up,ctrl-j:preview-down" | \
          awk '{print $1}' | \
          xargs gh pr checkout
      }
      if [[ -o interactive ]]; then
          export GITHUB_TOKEN=$(cat /run/secrets/github/api_key)
      fi
    '';
  };
}
