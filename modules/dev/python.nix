
{  config, pkgs, system, defaultUser, defaultGit, ... }:

{
  environment.systemPackages = with pkgs; [ 
    python3
    python311Packages.pip
    python311Packages.virtualenv
    python311Packages.setuptools
    python311Packages.wheel
  ];
}
