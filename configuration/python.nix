{pkgs, ...}: {
  ####################################################################
  #  Python Configs
  ####################################################################

  environment.systemPackages = with pkgs; [
    python3Full
  ];
}
