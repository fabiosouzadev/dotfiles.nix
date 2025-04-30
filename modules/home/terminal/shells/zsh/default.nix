{...}: {
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
    initContent = ''
      if [[ -o interactive ]]; then
          export OPENAI_API_KEY=$(cat /run/secrets/openai/api_key)
          export SRC_ENDPOINT=$(cat /run/secrets/sourcegraph/endpoint)
          export SRC_ACCESS_TOKEN=$(cat /run/secrets/sourcegraph/access_token)
          export ANTHROPIC_API_KEY=$(cat /run/secrets/anthropic/api_key)
          export GEMINI_API_KEY=$(cat /run/secrets/gemini/api_key)
          export GROQ_API_KEY=$(cat /run/secrets/groq/api_key)
      fi
    '';
  };
}
