{pkgs, ...}: {
  home.packages = with pkgs; [
    awscli2
  ];

  programs.zsh = {
    shellAliases = {
      k9s_prod = "k9s --kubeconfig ~/.dotfiles.nix/zapay/kube/zapay-production.yaml";
      k9s_stg = "k9s --kubeconfig ~/.dotfiles.nix/zapay/kube/zapay-staging.yaml";
      aws_zapay_login = "aws sso login --sso-session aws-zapay";
      aws_zapay_kube_prod = "aws eks update-kubeconfig --region sa-east-1 --name zapay-one --profile aws-zapay-prod";
      aws_zapay_kube_stg = "aws eks update-kubeconfig --region us-east-2 --name zpy-k8s-cluster-staging --profile aws-zapay-stg";
      aws_zapay_login_ecr = "aws ecr get-login-password --region sa-east-1 --profile Fabio_Souza-071032557399 | docker login --username AWS --password-stdin 071032557399.dkr.ecr.sa-east-1.amazonaws.com";
      aws_vpn = "awsvpnclient start --config ~/.dotfiles.nix/zapay/aws/vpn/config.ovpn";
    };
  };
}
