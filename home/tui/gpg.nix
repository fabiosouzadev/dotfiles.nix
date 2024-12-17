{pkgs, ...}: {
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    defaultCacheTtl = 34560000; # cache keys forever don't get asked for password
    defaultCacheTtlSsh = 34560000; # cache keys forever don't get asked for password
    maxCacheTtl = 34560000;
    maxCacheTtlSsh = 34560000;
    enableSshSupport = true;
    pinentryPackage = pkgs.pinentry-tty;
    # pinentryPackage = pkgs.pinentry-curses;
    # pinentryPackage = pkgs.pinentry-gtk2;
    sshKeys = ["FBB635DEEB7F34838A309D34366402035F3025A8"];
    enableScDaemon = false;
  };
}
