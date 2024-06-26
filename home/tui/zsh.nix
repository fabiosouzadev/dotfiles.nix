{ config, ... }:
{
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
    sessionVariables = {
      OPENAI_API_KEY = builtins.readFile config.sops.secrets."openai/api_key".path;
      SRC_ENDPOINT = builtins.readFile config.sops.secrets."sourcegraph/endpoint".path;
      SRC_ACCESS_TOKEN = builtins.readFile config.sops.secrets."sourcegraph/access_token".path;
    };
    # shellAliases = {
    # };
  };
}
