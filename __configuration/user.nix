{
  pkgs,
  config,
  username,
  ...
}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.user-password.path;
    description = "Fabio Souza";
    extraGroups = ["networkmanager" "wheel" "audio" "bluetooth" "docker"];
    home = "/home/${username}";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICZfQfANchWqcYPZiZtMQ7UByj/pReoe3HjYCpTkq4JT fabiovanderlei.developer@gmail.com"
    ];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
  environment.shells = [pkgs.zsh];
}
