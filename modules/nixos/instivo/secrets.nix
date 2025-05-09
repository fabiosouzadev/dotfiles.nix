{
  inputs,
  config,
  vars,
  ...
}: let
  instivoSecrets = "${builtins.toString inputs.mysecrets}/instivo/secrets.yaml";
  homepath = config.users.users.${vars.username}.home;
in {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  sops = {
    # defaultSopsFormat = "yaml";
    # validateSopsFiles = false;
    #
    # age = {
    #   sshKeyPaths = ["${homepath}/.ssh/primary_ed25519"];
    #   keyFile = "${homepath}/.config/sops/age/keys.txt";
    #   generateKey = true;
    # };

    secrets = {
      "instivo/aws/access_key_id" = {
        sopsFile = instivoSecrets;
        owner = vars.username;
      };
      "instivo/aws/secret_access_key" = {
        sopsFile = instivoSecrets;
        owner = vars.username;
      };
    };
    templates."aws/credentials" = {
      content = ''
        [default]
        aws_access_key_id=${config.sops.placeholder."instivo/aws/access_key_id"}
        aws_secret_access_key=${config.sops.placeholder."instivo/aws/secret_access_key"}
      '';
      path = "${homepath}/.aws/credentials";
      owner = vars.username;
    };
    templates."aws/config" = {
      content = ''
        [default]
        region=us-east-2
        output=json
      '';
      path = "${homepath}/.aws/config";
      owner = vars.username;
    };
  };
}
