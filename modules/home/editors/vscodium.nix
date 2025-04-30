{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles = {
      default = {
        extensions = with pkgs.vscode-extensions; [
          catppuccin.catppuccin-vsc
          catppuccin.catppuccin-vsc-icons
          vscodevim.vim
          # sonarsource.sonarlint-vscode
        ];
        # userSettings = {
        #   "terminal.integrated.fontFamily" = "Hack";
        # };
      };
    };
  };
}
