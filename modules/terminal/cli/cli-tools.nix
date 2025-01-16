{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    zip
    unzip
    p7zip
    htop
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
      config = {theme = "Catppuccin Mocha";};
      themes = {
        "Catppuccin Mocha" = {
          src =
            pkgs.fetchFromGitHub
            {
              owner = "catppuccin";
              repo = "bat";
              rev = "d2bbee4f7e7d5bac63c054e4d8eca57954b31471";
              sha256 = "sha256-x1yqPCWuoBSx/cI94eA+AWwhiSA42cLNUOFJl7qjhmw=";
            };
          file = "themes/Catppuccin Mocha.tmTheme";
        };
      };
    };
    eza = {
      enable = true;
      git = true;
      icons = "auto";
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

    btop = {
      enable = true;
      settings = {
        vim_keys = true;
      };
    };
  };
}
