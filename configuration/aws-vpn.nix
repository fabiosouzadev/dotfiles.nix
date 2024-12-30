{inputs, ...}: {
  imports = [inputs.aws-vpn-client.nixosModules.x86_64-linux.default];

  programs.awsvpnclient.enable = true;
}
