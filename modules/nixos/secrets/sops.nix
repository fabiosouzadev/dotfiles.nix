{
  config,
  inputs,
  pkgs,
  vars,
  ...
}: let
  secretspath = builtins.toString inputs.mysecrets;
  homepath = config.users.users.${vars.username}.home;
in {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  sops = {
    defaultSopsFile = "${secretspath}/secrets.yaml";
    defaultSopsFormat = "yaml";
    validateSopsFiles = false;

    age = {
      sshKeyPaths = ["${homepath}/.ssh/primary_ed25519"];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    secrets = {
      user-password = {
        neededForUsers = true;
      };
      "openai/api_key" = {
        owner = config.users.users.${vars.username}.name;
      };
      "sourcegraph/endpoint" = {
        owner = config.users.users.${vars.username}.name;
      };
      "sourcegraph/access_token" = {
        owner = config.users.users.${vars.username}.name;
      };
      "github/api_key" = {
        owner = config.users.users.${vars.username}.name;
      };
      "syncthing/SM-A715F" = {
        owner = config.users.users.${vars.username}.name;
      };
      "anthropic/api_key" = {
        owner = config.users.users.${vars.username}.name;
      };
      "gemini/api_key" = {
        owner = config.users.users.${vars.username}.name;
      };
      "groq/api_key" = {
        owner = config.users.users.${vars.username}.name;
      };
      "deepseek/api_key" = {
        owner = config.users.users.${vars.username}.name;
      };
    };
  };
  environment.systemPackages = with pkgs; [
    sops
  ];
}
