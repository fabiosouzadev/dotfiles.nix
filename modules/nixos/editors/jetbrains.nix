{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # OpenJDK fork to better support Jetbrains's products
    jetbrains.jdk-no-jcef

    #Pycharm
    jetbrains.pycharm-community-src # from source
    # jetbrains.pycharm-community-bin # patched binaries from jetbrains
    #jetbrains.pycharm-community # patched binaries from jetbrains

    # Idea
    jetbrains.idea-community-src
    #jetbrains.idea-community-bin
    #jetbrains.idea-community

    # Android
    androidStudioPackages.beta

    # phpstorm
    #jetbrains.phpstorm

    # webstorm
    jetbrains.webstorm
  ];
}
