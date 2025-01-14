{
  inputs,
  config,
  username,
  pkgs,
  ...
}: let
  secretspath = builtins.toString inputs.mysecrets;
  homepath = config.users.users.${username}.home;
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
      keyFile = "${homepath}/.config/sops/age/keys.txt";
      generateKey = true;
    };

    secrets = {
      user-password = {
        neededForUsers = true;
      };
      "openai/api_key" = {
        owner = config.users.users.${username}.name;
      };
      "sourcegraph/endpoint" = {
        owner = config.users.users.${username}.name;
      };
      "sourcegraph/access_token" = {
        owner = config.users.users.${username}.name;
      };
      "github/api_key" = {
        owner = config.users.users.${username}.name;
      };
      "syncthing/SM-A715F" = {
        owner = config.users.users.${username}.name;
      };
      "anthropic/api_key" = {
        owner = config.users.users.${username}.name;
      };
      "gemini/api_key" = {
        owner = config.users.users.${username}.name;
      };
      "groq/api_key" = {
        owner = config.users.users.${username}.name;
      };
    };
  };
  environment.systemPackages = with pkgs; [
    sops
  ];
}
