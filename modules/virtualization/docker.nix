{  config, pkgs, defaultUser, defaultGit, ... }:

{
  virtualisation = {
    docker.enable = true;
  };

  users.groups.docker.members = [ "${defaultUser}" ];

  environment.systemPackages = with pkgs; [
    docker                  # Containers
    docker-compose          # Multi-Container
  ];
}
