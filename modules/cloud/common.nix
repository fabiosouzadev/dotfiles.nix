
{  config, pkgs, defaultUser, defaultGit, ... }:

{
  
  home-manager.users.${defaultUser} = {
    home.packages = with pkgs; [
	k3s
	kind
	minikube
	k9s
	#lens
	#k6 # load testing tool
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
    - "~/.dotfiles.nix/zapay/kube"
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
#     #   - hering-integracoes-b2c-dev
    '';
    home.file.".config/k9s/skin.yml".text = ''
# Styles...
foreground: &foreground "#f8f8f2"
background: &background "default"
current_line: &current_line "#44475a"
selection: &selection "#44475a"
comment: &comment "#6272a4"
cyan: &cyan "#8be9fd"
green: &green "#50fa7b"
orange: &orange "#ffb86c"
pink: &pink "#ff79c6"
purple: &purple "#bd93f9"
red: &red "#ff5555"
yellow: &yellow "#f1fa8c"

# Skin...
k9s:
  # General K9s styles
  body:
    fgColor: *foreground
    bgColor: *background
    logoColor: *purple
  # Command prompt styles
  prompt:
    fgColor: *foreground
    bgColor: *background
    suggestColor: *purple
  # ClusterInfoView styles.
  info:
    fgColor: *pink
    sectionColor: *foreground
  # Dialog styles.
  dialog:
    fgColor: *foreground
    bgColor: *background
    buttonFgColor: *foreground
    buttonBgColor: *purple
    buttonFocusFgColor: *yellow
    buttonFocusBgColor: *pink
    labelFgColor: *orange
    fieldFgColor: *foreground
  frame:
    # Borders styles.
    border:
      fgColor: *selection
      focusColor: *current_line
    menu:
      fgColor: *foreground
      keyColor: *pink
      # Used for favorite namespaces
      numKeyColor: *pink
    # CrumbView attributes for history navigation.
    crumbs:
      fgColor: *foreground
      bgColor: *current_line
      activeColor: *current_line
    # Resource status and update styles
    status:
      newColor: *cyan
      modifyColor: *purple
      addColor: *green
      errorColor: *red
      highlightcolor: *orange
      killColor: *comment
      completedColor: *comment
    # Border title styles.
    title:
      fgColor: *foreground
      bgColor: *current_line
      highlightColor: *orange
      counterColor: *purple
      filterColor: *pink
  views:
    # Charts skins...
    charts:
      bgColor: default
      defaultDialColors:
        - *purple
        - *red
      defaultChartColors:
        - *purple
        - *red
    # TableView attributes.
    table:
      fgColor: *foreground
      bgColor: *background
      cursorFgColor: *foreground
      cursorBgColor: *current_line
      # Header row styles.
      header:
        fgColor: *foreground
        bgColor: *background
        sorterColor: *cyan
    # Xray view attributes.
    xray:
      fgColor: *foreground
      bgColor: *background
      cursorColor: *current_line
      graphicColor: *purple
      showIcons: false
    # YAML info styles.
    yaml:
      keyColor: *pink
      colonColor: *purple
      valueColor: *foreground
    # Logs styles.
    logs:
      fgColor: *foreground
      bgColor: *background
      indicator:
        fgColor: *foreground
        bgColor: *purple
    '';
      
    programs.zsh = {
      shellAliases = {
       k9s_prod = "k9s --kubeconfig ~/.dotfiles.nix/zapay/kube/zapay-production.yaml"; 
       k9s_stg = "k9s --kubeconfig ~/.dotfiles.nix/zapay/kube/zapay-staging.yaml";
       aws_login_prod = "aws sso login --profile Fabio_Souza-071032557399";
       aws_login_stg = "aws sso login --profile Fabio_Souza 901943060028";
      };
    };

  };

}
