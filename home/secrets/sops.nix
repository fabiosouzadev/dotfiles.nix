{ inputs, config, ... }:
let
  secretspath = builtins.toString inputs.mysecrets;
in
{

  sops = {

    defaultSopsFile = "${secretspath}/secrets.yaml";
    defaultSopsFormat = "yaml";
    validateSopsFiles = false;

    age = {
      sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/primary_ed25519" ];
      keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
      generateKey = true;
    };

    secrets = {
      "openai/api_key" = { };
      "sourcegraph/endpoint" = { };
      "sourcegraph/access_token" = { };
    };

  };

}
