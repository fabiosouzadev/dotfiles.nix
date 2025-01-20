{
  config,
  pkgs,
  ...
}: {
  programs = {
    fd.enable = true;
    jq.enable = true;
    ripgrep.enable = true;
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };
  };
}
