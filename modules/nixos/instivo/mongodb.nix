{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ### MongoDB tools
    # mongodb-cli
    mongodb-compass
  ];
}
