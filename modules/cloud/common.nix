
{  config, pkgs, defaultUser, defaultGit, ... }:

{
  
  home-manager.users.${defaultUser} = {
    home.packages = with pkgs; [
        #kubectl
	k3s
	kind
	k9s
	kubeswitch
    ];
  };

}
