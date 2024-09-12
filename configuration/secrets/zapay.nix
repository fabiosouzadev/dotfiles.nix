{
  inputs,
  config,
  username,
  ...
}: let
  secretspath = builtins.toString inputs.mysecrets;
  zapaySecrets = "${secretspath}/zapay/secrets.yaml";
  homepath = config.users.users.${username}.home;
in {
  # imports = [
  #   inputs.sops-nix.nixosModules.sops
  # ];
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
      "aws-zapay/sso_role_name" = {
        sopsFile = zapaySecrets;
      };
      "aws-zapay/sso_start_url" = {
        sopsFile = zapaySecrets;
      };
      "aws-zapay/staging/sso_account_id_staging" = {
        sopsFile = zapaySecrets;
      };
      "aws-zapay/staging/sso_region_staging" = {
        sopsFile = zapaySecrets;
      };
      "aws-zapay/staging/source_profile_staging" = {
        sopsFile = zapaySecrets;
      };
      "aws-zapay/staging/role_arn_staging" = {
        sopsFile = zapaySecrets;
      };
      "aws-zapay/staging/cluster_name_staging" = {
        sopsFile = zapaySecrets;
      };
      "aws-zapay/staging/cluster_server_staging" = {
        sopsFile = zapaySecrets;
      };
      "aws-zapay/staging/cluster_certificate_staging" = {
        sopsFile = zapaySecrets;
      };
      "aws-zapay/production/sso_account_id_production" = {
        sopsFile = zapaySecrets;
      };
      "aws-zapay/production/sso_region_production" = {
        sopsFile = zapaySecrets;
      };
      "aws-zapay/production/source_profile_production" = {
        sopsFile = zapaySecrets;
      };
      "aws-zapay/production/role_arn_production" = {
        sopsFile = zapaySecrets;
      };
      "aws-zapay/production/cluster_name_production" = {
        sopsFile = zapaySecrets;
      };
      "aws-zapay/production/cluster_server_production" = {
        sopsFile = zapaySecrets;
      };
      "aws-zapay/production/cluster_certificate_production" = {
        sopsFile = zapaySecrets;
      };
    };
    # templates."aws/config" = {
    #   content = ''
    #     [sso-session aws-zapay]
    #     sso_start_url = ${config.sops.placeholder."aws-zapay/sso_start_url"}
    #     sso_region = ${config.sops.placeholder."aws-zapay/production/sso_region_production"}
    #     sso_registration_scopes = sso:account:access
    #
    #     [profile ${config.sops.placeholder."aws-zapay/production/source_profile_production"}]
    #     sso_session = aws-zapay
    #     sso_account_id = ${config.sops.placeholder."aws-zapay/production/sso_account_id_production"}
    #     sso_role_name = ${config.sops.placeholder."aws-zapay/sso_role_name"}
    #     region = ${config.sops.placeholder."aws-zapay/production/sso_region_production"}
    #
    #     [profile ${config.sops.placeholder."aws-zapay/staging/source_profile_staging"}]
    #     sso_session = aws-zapay
    #     sso_account_id = ${config.sops.placeholder."aws-zapay/staging/sso_account_id_staging"}
    #     sso_role_name = ${config.sops.placeholder."aws-zapay/sso_role_name"}
    #     region = ${config.sops.placeholder."aws-zapay/staging/sso_region_staging"}
    #
    #     [profile aws-zapay-prod]
    #     role_arn = ${config.sops.placeholder."aws-zapay/production/role_arn_production"}
    #     source_profile = ${config.sops.placeholder."aws-zapay/production/source_profile_production"}
    #
    #     [profile aws-zapay-stg]
    #     role_arn = ${config.sops.placeholder."aws-zapay/staging/role_arn_staging"}
    #     source_profile = ${config.sops.placeholder."aws-zapay/staging/source_profile_staging"}
    #   '';
    #   path = "${homepath}/.aws/config";
    #   owner = config.users.users.${username}.name;
    # };
    templates."zapay_aws_staging" = {
      content = ''
        apiVersion: v1
        clusters:
        - cluster:
            certificate-authority-data: ${config.sops.placeholder."aws-zapay/staging/cluster_certificate_staging"}
            server: ${config.sops.placeholder."aws-zapay/staging/cluster_server_staging"}
          name: ${config.sops.placeholder."aws-zapay/staging/cluster_name_staging"}
        contexts:
        - context:
            cluster: ${config.sops.placeholder."aws-zapay/staging/cluster_name_staging"}
            user: ${config.sops.placeholder."aws-zapay/staging/cluster_name_staging"}
          name: ${config.sops.placeholder."aws-zapay/staging/cluster_name_staging"}
        current-context: ${config.sops.placeholder."aws-zapay/staging/cluster_name_staging"}
        kind: Config
        preferences: {}
        users:
        - name: ${config.sops.placeholder."aws-zapay/staging/cluster_name_staging"}
          user:
            exec:
              apiVersion: client.authentication.k8s.io/v1beta1
              args:
              - --region
              - us-east-2
              - eks
              - get-token
              - --cluster-name
              - zpy-k8s-cluster-staging
              - --output
              - json
              command: aws
              env:
              - name: AWS_PROFILE
                value: aws-zapay-stg
      '';
      path = "${homepath}/.kube/zapay_aws_staging.yaml";
      owner = config.users.users.${username}.name;
    };
    templates."zapay_aws_production" = {
      content = ''
        apiVersion: v1
        clusters:
        - cluster:
            certificate-authority-data: ${config.sops.placeholder."aws-zapay/production/cluster_certificate_production"}
            server: ${config.sops.placeholder."aws-zapay/production/cluster_server_production"}
          name: ${config.sops.placeholder."aws-zapay/production/cluster_name_production"}
        contexts:
        - context:
            cluster: ${config.sops.placeholder."aws-zapay/production/cluster_name_production"}
            user: ${config.sops.placeholder."aws-zapay/production/cluster_name_production"}
          name: ${config.sops.placeholder."aws-zapay/production/cluster_name_production"}
        current-context: ${config.sops.placeholder."aws-zapay/production/cluster_name_production"}
        kind: Config
        preferences: {}
        users:
        - name: ${config.sops.placeholder."aws-zapay/production/cluster_name_production"}
          user:
            exec:
              apiVersion: client.authentication.k8s.io/v1beta1
              args:
              - --region
              - sa-east-1
              - eks
              - get-token
              - --cluster-name
              - zapay-one
              - --output
              - json
              command: aws
              env:
              - name: AWS_PROFILE
                value: aws-zapay-prod
      '';
      path = "${homepath}/.kube/zapay_aws_production.yaml";
      owner = config.users.users.${username}.name;
    };
  };
}
