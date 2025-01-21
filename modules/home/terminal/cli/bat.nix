{pkgs, ...}: {
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
    zsh = {
      shellAliases = {
        "cat" = "${pkgs.bat}/bin/bat";
      };
    };
  };
}
