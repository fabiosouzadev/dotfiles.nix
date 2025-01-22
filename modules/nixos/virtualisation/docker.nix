{
  pkgs,
  vars,
  ...
}: {
  virtualisation = {
    docker.enable = true;
  };

  users.groups.docker.members = ["${vars.username}"];

  environment.systemPackages = with pkgs; [
    docker # Containers
    docker-compose # Multi-Container
    lazydocker
  ];
}
