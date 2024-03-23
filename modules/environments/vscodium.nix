
{  config, pkgs, defaultUser, defaultGit, myNvim, ... }:

{
  environment.systemPackages = with pkgs; [
    vscodium 
  ];
 
}
