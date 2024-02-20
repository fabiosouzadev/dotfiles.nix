{ pkgs, ... }: 
{
   #----=[ Fonts ]=----#
  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-design-icons

      # normal fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji

      # nerdfonts
      (nerdfonts.override {fonts = [
        "CascadiaCode"
        "FiraCode"
        "FiraMono"
        "Hack"
        "JetBrainsMono"
        "VictorMono"
        "IBMPlexMono"
        "SourceCodePro"
        "SpaceMono"
        "NerdFontsSymbolsOnly"
        "Ubuntu"
        "UbuntuMono"
        "Inconsolata"
        "Iosevka"
        "IosevkaTerm"
        "FantasqueSansMono"
        "DroidSansMono"
        "Noto"
        "RobotoMono"
        "Terminus"
        "DejaVuSansMono"];
      })
    ];

    # use fonts specified by user rather than default ones
    enableDefaultPackages = false;

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
    serif = ["Noto Serif" "Noto Color Emoji"];
    sansSerif = ["Noto Sans" "Noto Color Emoji"];
    monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
    emoji = ["Noto Color Emoji"];
    };
  };
}
