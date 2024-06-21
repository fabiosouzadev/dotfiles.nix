{ ... }: {
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
      # GITHUB_TOKEN = "pass Github/access_token_gh";
      SRC_ACCESS_TOKEN = "pass Sourcegraph/access_token_sg";
      SRC_ENDPOINT = "pass Sourcegraph/endpoint_sg";
    };
    # shellAliases = {
    # };
  };
}
