{
  config,
  username,
  ...
}: let
  homepath = config.users.users.${username}.home;
  configDir = "${homepath}/.config/syncthing";
  dataDir = "${homepath}/syncthing";
in {
  # Gui:http://127.0.0.1:8384/
  services = {
    syncthing = {
      enable = true;
      user = username;
      dataDir = "${dataDir}";
      configDir = "${configDir}";
      overrideFolders = false;
      overrideDevices = false;
      settings = {
        devices = {
          "SM-A715F" = {
            id = config.sops.secrets."syncthing/SM-A715F".path;
            autoAcceptFolders = true;
          };
        };
        folders = {
          "obsidian" = {
            # Name of folder in Syncthing, also the folder ID
            id = "pfs54-pxd9z";
            path = "${dataDir}/obsidian"; # Which folder to add to Syncthing
            devices = ["SM-A715F"]; # Which devices to share the folder with
          };
          # "Example" = {
          #   path = "/home/myusername/Example";
          #   devices = ["device1"];
          #   ignorePerms = false; # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
          # };
        };
      };
    };
  };
}
