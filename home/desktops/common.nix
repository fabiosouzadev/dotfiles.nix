{  pkgs, ... }:
 
{
  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    #chat
    slack
    discord
    telegram-desktop
    whatsapp-for-linux

    #browsers
    brave
    firefox
    chromium
    qutebrowser

    #pdf-reader
    zathura

    #auth and passwords
    #authy
    bitwarden

    #players
    vlc
    mpv
    streamlink
    streamlink-twitch-gui-bin

    #db
    dbeaver
    mongosh

    # api-tool
    postman
    insomnia

    #downloaders
    yt-dlp
    twitch-dl
  ];
}
