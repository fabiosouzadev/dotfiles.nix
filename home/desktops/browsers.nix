{pkgs, ...}: {
  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    #browsers
    brave
    firefox
    chromium
    qutebrowser
    mullvad-browser
    librewolf
    vivaldi
    opera
    midori
    microsoft-edge-dev
  ];
}
