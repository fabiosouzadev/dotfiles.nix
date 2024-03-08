{  config, pkgs, defaultUser, defaultGit, ... }:
{
  home-manager.users.${defaultUser} = {
    home.packages = with pkgs; [
	(google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
    ];
  };
}
