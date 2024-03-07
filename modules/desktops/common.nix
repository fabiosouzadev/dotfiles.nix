{  config, pkgs, defaultUser, ... }:
 
{
  # Packages that should be installed to the user profile.
  home-manager.users.${defaultUser} = {
    home.packages = with pkgs; [
      #chat
      slack

      #browsers
      brave
      firefox
      chromium

      #auth and passwords
      authy
      bitwarden

      #music-client
      spotify
      vlc
      mpv

      #db
      dbeaver
      mongosh

      # api-tool
      #postman
      insomnia

      #downloaders
      yt-dlp
      twitch-dl
    ];
  };

}
