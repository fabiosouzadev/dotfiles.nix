{  config, pkgs, defaultUser, defaultGit, ... }:
{
  #home-manager.users.${defaultUser} = {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryFlavor = "tty";
    };
  #};
}
