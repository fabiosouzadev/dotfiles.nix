{  config, pkgs, defaultUser, ... }:
 
{
  # Packages that should be installed to the user profile.
  home-manager.users.${defaultUser} = {
    home.packages = with pkgs; [
      slack
      brave
      authy
      bitwarden
      spotify

      #db
      dbeaver
    ];
  };

}
