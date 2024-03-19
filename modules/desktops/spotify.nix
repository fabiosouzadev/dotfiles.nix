{  config, pkgs, defaultUser, ... }:

{

  home-manager.users.${defaultUser} = {
    home.packages = with pkgs; [
      spotify
      #spotifyd
      #spotify-tui
    ];
    #services.spotifyd = {
    #  enable = true;
    #  settings = {
    #    global = {
    #	  username = "12143380597";
    #	  password = "pass Spotify/12143380597";
    #	  device_name = "nix";
    #    };
    #  };
    # }; 
  };
}
