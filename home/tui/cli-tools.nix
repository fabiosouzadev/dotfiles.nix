{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    zip
    unzip
    p7zip
    htop
    btop
    fd
    devbox
    distrobox
    ngrok
    pgrok #ngrok alternative
    #vagrant
    wakatime
  ];
  programs = {
    bat = {
      enable = true;
      config = { theme = "catppuccin"; };
      themes = {
        catppuccin = {
          src =
            pkgs.fetchFromGitHub
              {
                owner = "catppuccin";
                repo = "bat";
                rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
                sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
              };
          file = "Catppuccin-macchiato.tmTheme";
        };
      };
    };
    eza = {
      enable = true;
      git = true;
      icons = true;
    };
    jq.enable = true;
    zoxide = {
      enable = true;
      # enableBashIntegration = true;
      enableZshIntegration = true;
      # enableNushellIntegration = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    ripgrep.enable = true;
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv = {
        enable = true;
      };
    };
    zsh = {
      initExtra = ''
        source <(devbox completion zsh); compdef _devbox devbox
      '';
      shellAliases = {
        "cat" = "${pkgs.bat}/bin/bat";
        # "grep" = "${pkgs.ripgrep}/bin/rg";
        "l" = "${pkgs.eza}/bin/eza -lF --time-style=long-iso --icons";
        "la" = "${pkgs.eza}/bin/eza -lah --tree";
        "ls" = "${pkgs.eza}/bin/eza -h --git --icons --color=auto --group-directories-first -s extension";
        "tree" = "${pkgs.eza}/bin/eza --tree --icons --tree";
        "direnv-install" = "echo \"use flake\" > .envrc && ${pkgs.direnv}/bin/direnv allow";
      };
    };
  };
}

