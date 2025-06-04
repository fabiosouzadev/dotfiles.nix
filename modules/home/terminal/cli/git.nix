{
  inputs,
  pkgs,
  ...
}: let
  defaultGit = {
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
      key = "9D79F9FD64781516";
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
      # commit.gpgsign = true;
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
      # STAGE & COMMIT
      ga = "git add"; # Stage arquivo específico
      gaa = "git add --all"; # Stage TUDO (tracked + untracked)
      gc = "git commit -v"; # Commit com diff no editor
      gcm = "git commit -m"; # Commit rápido com mensagem
      gca = "git commit --amend"; # Corrige último commit (mensagem/conteúdo)
      gac = "git add -A && git commit"; # Add ALL + commit (abre editor)

      # BRANCHES & CHECKOUT
      gco = "git checkout"; # Altera branch
      gcb = "git checkout -b"; # Cria nova branch e muda
      gbr = "git branch"; # Lista branches
      gbd = "git branch -d"; # Deleta branch local
      gbD = "git branch -D"; # Força delete branch

      # SYNC & REMOTE
      gcl = "git clone";
      gps = "git push";
      gpsf = "git push --force-with-lease"; # Push forçado (seguro)
      gpl = "git pull";
      gplr = "git pull --rebase"; # Pull com rebase (evita merges desnecessários)
      gft = "git fetch";
      gfu = "git fetch upstream"; # Para forks (GitHub workflow)

      # HISTORY & DIFF
      gl = "git log --oneline --graph --decorate -n 20"; # Histórico compacto
      glo = "git log --oneline --graph --decorate --all"; # Histórico completo
      gd = "git diff"; # Modificações não staged
      gdc = "git diff --cached"; # Modificações staged
      gds = "git diff --stat"; # Sumário de alterações

      # STASH
      gst = "git stash"; # Stash padrão
      gstp = "git stash pop"; # Aplica último stash e remove
      gstl = "git stash list"; # Lista todos os stashes

      # RESET & CLEAN
      gr = "git reset"; # Reset soft (mantém alterações)
      grh = "git reset --hard"; # Reset HARD (descarta TUDO)
      gclean = "git clean -fd"; # Remove arquivos untracked
    };
    initContent = ''
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
