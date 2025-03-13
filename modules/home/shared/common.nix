{
  inputs,
  pkgs,
  ...
}: {
  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    #chat
    # slack
    ferdium
    # discord
    # telegram-desktop
    # whatsapp-for-linux
    # rambox
    # beeper

    #produtivide
    todoist # command line todo list https://github.com/sachaos/todoist
    todoist-electron
    libreoffice
    hunspellDicts.pt-br #Hunspell dictionary for Portuguese (Brazil) from LibreOffice
    obsidian

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
    ngrok
    pgrok #ngrok alternative

    #downloaders
    yt-dlp
    twitch-dl
    # qbittorrent

    # tools
    unetbootin
    speedtest-cli

    #ftp client
    filezilla

    #screenshot tools
    flameshot
    scrot
    maim

    # IDE`s
    # code-cursor
    # zed-editor

    # disk
    gparted
    spotify

    # uncompress
    zip
    unzip
    p7zip

    htop
    devbox
    distrobox

    #monitoring
    wakatime
  ];
}
