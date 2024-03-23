{ pkgs, config, ...}:
{
  programs.ssh = {
   #enable = true;
   addKeysToAgent = "no";
  };
}

