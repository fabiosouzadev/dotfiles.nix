{
  pkgs,
  config,
  vars,
  ...
}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${vars.username} = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.user-password.path;
    description = "Fabio Souza";
    extraGroups = ["networkmanager" "wheel" "audio" "bluetooth" "docker"];
    home = "/home/${vars.username}";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICZfQfANchWqcYPZiZtMQ7UByj/pReoe3HjYCpTkq4JT fabiovanderlei.developer@gmail.com"
    ];
    shell = pkgs.${vars.shell};
  };
  programs.${vars.shell}.enable = true;
  environment = {
    pathsToLink = ["/share/zsh"];
    shells = with pkgs; [${vars.shell}];
    variables = {
      TERMINAL = "${vars.terminal}";
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.editor}";
    };
  };
}
