{  config, pkgs, defaultUser, defaultGit, ... }:
{
  home-manager.users.${defaultUser} = {
    programs.gpg.enable = true;
    services.gpg-agent = {
      defaultCacheTtl = 31536000; # cache keys forever don't get asked for password
      enable = true;
      maxCacheTtl = 31536000;
      pinentryFlavor = "tty";
    };
  };
}
