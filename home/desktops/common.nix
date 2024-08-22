{pkgs, ...}: {
  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    #chat
    slack
    discord
    telegram-desktop
    whatsapp-for-linux

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

    #downloaders
    yt-dlp
    twitch-dl
    qbittorrent

    # tools
    unetbootin

    #ftp client
    filezilla

    #screenshot tools
    flameshot
    scrot
    maim

    #vpn
    openvpn
    openvpn3
    # networkmanager-openvpn
    # gnome.networkmanager-openvpn
  ];
}
