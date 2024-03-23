{ pkgs, config, ...}:
{
  programs.starship =  {
    enable = true;
    settings = {
      add_newline = true;
      nix_shell = {
        symbol = " ";
        heuristic = true;
      };
    };
  };
}

