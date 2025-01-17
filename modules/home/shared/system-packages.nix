{pkgs, ...}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    pathsToLink = ["/libexec"];
    systemPackages = with pkgs; [
      #neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
      curl
      hurl #https://hurl.dev/
      git
      sysstat
      lm_sensors # for `sensors` command
      # minimal screen capture tool, used by i3 blur lock to take a screenshot
      # print screen key is also bound to this tool in i3 config
      scrot
      neofetch
      nnn # terminal file manager
      just
      unzip
      xsel
      xclip
      ueberzugpp
    ];
  };
}
