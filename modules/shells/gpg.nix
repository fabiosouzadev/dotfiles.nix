{  config, pkgs, defaultUser, defaultGit, ... }:
{
  home-manager.users.${defaultUser} = {
    programs.gpg.enable = true;
    services.gpg-agent = {
      enable = true;
      defaultCacheTtl = 31536000; # cache keys forever don't get asked for password
      maxCacheTtl = 31536000;
      enableSshSupport = true;
      pinentryFlavor = "tty";
    };
  };
}
