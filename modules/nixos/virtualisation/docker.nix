{
  pkgs,
  vars,
  ...
}: {
  virtualisation = {
    docker.enable = true;
  };

  users.groups.docker.members = ["${vars.username}"];
  users.extraGroups.docker.members = ["${vars.username}"];

  environment.systemPackages = with pkgs; [
    docker # Containers
    docker-compose # Multi-Container
    lazydocker
  ];
  programs.zsh = {
    shellAliases = {
      dk = "${pkgs.docker}/bin/docker";
      dkc = "${pkgs.docker-compose}/bin/docker-compose";
      ldk = "${pkgs.lazydocker}/bin/lazydocker";
      # k = "kubernetes";
    };
  };
}
