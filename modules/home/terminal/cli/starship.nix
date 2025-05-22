{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      sudo = {
        disabled = false;
      };
      nix_shell = {
        symbol = " ";
        heuristic = true;
      };
      direnv = {
        disabled = false;
      };
    };
  };
}
