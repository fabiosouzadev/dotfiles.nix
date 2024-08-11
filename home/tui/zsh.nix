{config, ...}: {
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
    initExtra = ''
      if [[ -o interactive ]]; then
          export OPENAI_API_KEY=$(cat /run/secrets/openai/api_key)
          export SRC_ENDPOINT=$(cat /run/secrets/sourcegraph/endpoint)
          export SRC_ACCESS_TOKEN=$(cat /run/secrets/sourcegraph/access_token)
      fi
    '';
  };
}
