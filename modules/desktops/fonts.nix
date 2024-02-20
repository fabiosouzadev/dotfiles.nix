{ pkgs, ... }: 
{
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
}
