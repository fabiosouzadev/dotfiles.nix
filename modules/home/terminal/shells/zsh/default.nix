{pkgs, ...}: {
  # basic configuration of git, please change to your own
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    history = {
      save = 10000000;
      size = 10000000;
      share = true;
    };
    shellAliases = {
      reload = "source ~/.zshrc";
      n = "nvim";
      v = "nvim";
      jb = "just build";
      jbw = "just build work";
      rdot = "source ~/.zshrc";
      work = "cd ~/Projects/Work/";
      winstivo = "cd ~/Projects/Work/Instivo/";
      personal = "cd ~/Projects/Personal/";
    };
    initContent = ''
      if [[ -o interactive ]]; then
          export OPENAI_API_KEY=$(cat /run/secrets/openai/api_key)
          export SRC_ENDPOINT=$(cat /run/secrets/sourcegraph/endpoint)
          export SRC_ACCESS_TOKEN=$(cat /run/secrets/sourcegraph/access_token)
          export ANTHROPIC_API_KEY=$(cat /run/secrets/anthropic/api_key)
          export GEMINI_API_KEY=$(cat /run/secrets/gemini/api_key)
          export GROQ_API_KEY=$(cat /run/secrets/groq/api_key)
          export DEEPSEEK_API_KEY=$(cat /run/secrets/deepseek/api_key)
      fi
    '';
  };
}
