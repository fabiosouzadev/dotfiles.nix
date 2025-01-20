{
  config,
  pkgs,
  ...
}: {
  programs = {
    eza = {
      enable = true;
      git = true;
      icons = "auto";
    };
    zsh = {
      shellAliases = {
        "l" = "${pkgs.eza}/bin/eza -lF --time-style=long-iso --icons";
        "la" = "${pkgs.eza}/bin/eza -lah --tree";
        "ls" = "${pkgs.eza}/bin/eza -h --git --icons --color=auto --group-directories-first -s extension";
        "tree" = "${pkgs.eza}/bin/eza --tree --icons --tree";
      };
    };
  };
}
