
{  config, pkgs, defaultUser, defaultGit, ... }:

{
  environment.systemPackages = with pkgs; [ 
    python3
    pyenv
  ];  
}
