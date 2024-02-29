{  config, pkgs, defaultUser, defaultGit, ... }:
{
  home-manager.users.${defaultUser} = {
    home.packages = with pkgs; [
      awscli2
      aws-sso-cli
      aws-sso-creds
    ];
  };
}
