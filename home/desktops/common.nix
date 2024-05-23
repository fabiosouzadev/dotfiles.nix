{ pkgs, ... }:

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
    mullvad-browser

    #pdf-reader
    zathura

    #auth and passwords
    bitwarden

    #players
    vlc
    mpv
    # streamlink
    streamlink-twitch-gui-bin

    #db
    dbeaver-bin
    mongosh

    # api-tool
    postman
    insomnia

    #downloaders
    yt-dlp
    twitch-dl

    # tools
    unetbootin
  ];
}
