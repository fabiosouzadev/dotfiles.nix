{  pkgs, ... }:

{
   environment.systemPackages = with pkgs; [
    
    #Pycharm
    jetbrains.pycharm-community-src # from source
    #jetbrains.pycharm-community-bin # patched binaries from jetbrains
    #jetbrains.pycharm-community # patched binaries from jetbrains
    
    # Idea
    #jetbrains.idea-community-src
    #jetbrains.idea-community-bin
    #jetbrains.idea-community

    # Android
    # android-studio
  ];
}
