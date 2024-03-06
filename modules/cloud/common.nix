
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

    home.file.".kube/switch-config.yaml".text = ''
    kind: SwitchConfig
    version: v1alpha1
    kubeconfigStores:
    - kind: filesystem
      id: config
      paths:
       - "~/.kube/"
   - kind: filesystem
     id: zapay
     kubeconfigName: "zapay-*"
     paths:
    - "~/.kube/zapay/"
   # - kind: gke
   #   refreshIndexAfter: 3h
   #   config:
   #     # optionally set the account. Otherwise, the currently active gcloud account will be used.
   #     gcpAccount: fabio.souza@ciahering.com.br
   #     authentication:
   #       authenticationType: gcloud
   #   cache:
   #     kind: filesystem
   #     config:
   #       path: ~/.cache/kube/
   #     # optionally limit to certain projects in account
   #     # projectIDs:
   #     #   - hering-integracoes-b
    '';
   # home.file.".kube/zapay" = {
   # source = ../../zapay;
   # recursive = true;
   # };

  };

}
