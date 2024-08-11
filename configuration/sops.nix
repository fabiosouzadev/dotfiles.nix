{
  inputs,
  config,
  username,
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
      "aws-zapay/user" = {};
      "aws-zapay/access_key_id" = {};
      "aws-zapay/secret_access_key" = {};
      "aws-zapay/session_token" = {};
    };
    templates."aws/credentials" = {
      content = ''
        [${config.sops.placeholder."aws-zapay/user"}]
        aws_access_key_id=${config.sops.placeholder."aws-zapay/access_key_id"}
        aws_secret_access_key=${config.sops.placeholder."aws-zapay/secret_access_key"}
        aws_session_token=${config.sops.placeholder."aws-zapay/session_token"}
      '';
      path = "${homepath}/.aws/credentials";
      owner = config.users.users.${username}.name;
    };
  };
}
