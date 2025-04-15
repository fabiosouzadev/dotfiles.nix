{pkgs, ...}: let
  nerd-pkgs = with pkgs.nerd-fonts; [
    fira-code
    fira-mono
    hack
    jetbrains-mono
    symbols-only
    iosevka
    iosevka-term
    fantasque-sans-mono
    noto
    droid-sans-mono
    ubuntu
    ubuntu-mono
  ];
in {
  # After 25.05 (Not fully completed and officially released yet)
  fonts = {
    packages = with pkgs;
      [
        material-icons
        icomoon-feather
        siji
        noto-fonts-emoji
        lato
      ]
      ++ nerd-pkgs;
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      antialias = true;
      defaultFonts = {
        # serif = ["Roboto Slab"];
        # sansSerif = ["Inter"];
        # monospace = ["Iosevka"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
