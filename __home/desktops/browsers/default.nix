{pkgs, ...}: {
  # Packages that should be installed to the user profile.
  imports = [
    ./librewolf.nix
  ];
  home.packages = with pkgs; [
    #browsers
    brave
    firefox
    chromium
    qutebrowser
    mullvad-browser
    vivaldi
    opera
    # midori
    microsoft-edge
  ];
}
