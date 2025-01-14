{
  inputs,
  pkgs,
  username,
  ...
}: let
  defaultGit = {
    extraConfig.github.user = username;
    userEmail = "fabiovanderlei.developer@gmail.com";
    userName = "Fabio Souza";
  };

  delta = inputs.catppuccin-delta;
in {
  home.packages = with pkgs; [
    lazygit
    gh #github
  ];
  programs.git = {
    enable = true;
    includes = [{path = "${delta}/catppuccin.gitconfig";}];

    userName = defaultGit.userName;
    userEmail = defaultGit.userEmail;

    signing = {
      key = "64781516";
      signByDefault = true;
    };

    delta = {
      enable = true;
      options = {
        side-by-side = true;
        navigate = true;
        line-numbers = true;
        features = "catppuccin-mocha";
      };
    };
    extraConfig = {
      color.ui = true;
      commit.gpgsign = true;
      core.editor = "nvim";
      diff.colorMoved = "zebra";
      fetch.prune = true;
      init.defaultBranch = "main";
      merge.conflictstyle = "zdiff3";
      push.autoSetupRemote = true;
      rebase.autoStash = true;
    };
  };

  programs.zsh = {
    shellAliases = {
      gitgrep = "git ls-files | rg";
    };
    initExtra = ''
      gpr() {
        GH_FORCE_TTY="100%" \
        gh pr list | \
          fzf --ansi \
            --preview 'GH_FORCE_TTY="100%" gh pr view {1}' \
            --preview-window down  --header-lines 3 | \
            --bind "ctrl-k:preview-up,ctrl-j:preview-down" | \
          awk '{print $1}' | \
          xargs gh pr checkout
      }

      gprtx() {
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
