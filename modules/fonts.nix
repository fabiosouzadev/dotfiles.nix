{ pkgs, ... }: 
{
  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [
    (nerdfonts.override { 
      fonts = [ 
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
          "DejaVuSansMono"
      ]; 
    })
  ];
}