{pkgs, ...}: {
  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    #browsers
    brave
    firefox
    chromium
    qutebrowser
    mullvad-browser
    floorp
    librewolf
    ladybird
    vivaldi
    opera
    midori
    microsoft-edge-dev
  ];
}

