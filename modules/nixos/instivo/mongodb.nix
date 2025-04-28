{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ### MongoDB tools

    # mongodb-cli
    mongodb-compass
    mongodb-tools
    mongosh
    # nosql-booster
    # robo3t
    # vi-mongo
    dbgate
  ];
}
