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
      pull.rebase = true; # Prefira rebase ao invés de merge no pull
      merge.conflictstyle = "zdiff3";
      push.autoSetupRemote = true;
      rebase.autoStash = true;
      # GitHub CLI como helper de credencial (opcional, mas bom)
      credential.helper = "${pkgs.gh}/bin/gh auth git-credential";
    };
  };

  programs.zsh = {
    shellAliases = {
      g = "git";
      # STAGE & COMMIT
      ga = "git add"; # Stage arquivo específico
      gaa = "git add --all"; # Stage TUDO (tracked + untracked)
      gc = "git commit -v"; # Commit com diff no editor
      gcm = "git commit -m"; # Commit rápido com mensagem
      gca = "git commit --amend"; # Corrige último commit (mensagem/conteúdo)
      gac = "git add -A && git commit -v"; # Add ALL + commit (abre editor)
      gacm = "git add -A && git commit -m"; # Add ALL + commit (commit rapido)

      # BRANCHES & CHECKOUT
      gco = "git checkout"; # Altera branch
      gcb = "git checkout -b"; # Cria nova branch e muda
      gbr = "git branch"; # Lista branches
      gbd = "git branch -d"; # Deleta branch local
      gbdr = "git push origin --delete"; # Deleta branch remota
      gbD = "git branch -D"; # Força delete branch
      gcop = "git branch | fzf | xargs git checkout"; # Branch picker interativo (usa fzf)

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
      glp = "git log --oneline --graph --decorate --all --pretty='%C(yellow)%h%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"; # Log colorido com autor e tempo relativo
      gd = "git diff"; # Modificações não staged
      gdc = "git diff --cached"; # Modificações staged
      gds = "git diff --stat"; # Sumário de alterações
      gdsh = "git diff --stat HEAD"; # Estatísticas das alterações atuais
      gref = "git reflog"; # Histórico de referências (útil para recuperar commits perdidos)

      # STASH
      gst = "git stash"; # Stash padrão
      gstp = "git stash pop"; # Aplica último stash e remove
      gstl = "git stash list"; # Lista todos os stashes
      gsts = "git stash push -m"; # Stash com mensagem descritiva
      gsta = "git stash apply"; # Aplica stash sem remover

      # RESET & CLEAN
      gr = "git reset"; # Reset soft (mantém alterações)
      grh = "git reset --hard"; # Reset HARD (descarta TUDO)
      grhc = "git reset --hard && git clean -fd"; # Reset completo + remove untracked
      gclean = "git clean -fd"; # Remove arquivos untracked
      gprune = "git fetch --prune && git branch --merged | grep -v '\\*' | xargs -n 1 git branch -d"; # Deleta branches locais já mescladas

      # STATUS
      gs = "git status"; # Status completo
      gss = "git status --short"; # Status compacto

      # MERGE
      gm = "git merge"; # Merge simples
      gma = "git merge --abort"; # Aborta merge em caso de conflitos
      gmc = "git merge --continue"; # Continua após resolver conflitos

      # GREP e BLAME
      gg = "git grep"; # Busca em arquivos (rápido)
      gbl = "git blame"; # Mostra autor por linha
      gblc = "git blame -C"; # Blame com detecção de cópias/movimentações

      ## REBASE
      gri = "git rebase -i"; # Ex: `gri HEAD~3` # REBASE INTERATIVO (squash/reword/edit commits)
      gup = "git fetch upstream && git rebase upstream/main"; # Sincroniza fork com upstream
      grbmain = "git fetch origin && git rebase origin/main"; # Rebase com main remota

      # VIEW (informações úteis)
      gwho = "git shortlog -s -n"; # Top contribuidores
      gwt = "git worktree list"; # Lista worktrees

      # GREP PODEROSO (com fzf + ripgrep)
      ggrep = "git ls-files | rg"; # Busca em todos os arquivos versionados

      # CONFLICT RESOLUTION
      gml = "git diff --name-only --diff-filter=U"; # Lista arquivos com conflito
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
