{  config, pkgs, ... }:
 
{
  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    slack
    brave
    authy
    bitwarden
    spotify
  ];

}