{
  userSettings,
  syncthingArgs,
  lib,
  host,
  ...
}:
let
  syncDirs = [
    "Documents"
    "Pictures"
    "Music"
    "Videos"
  ];

  _ = lib.assertMsg
    (syncthingArgs ? ${host})
    "Syncthing: host '${host}' not found in syncthingArgs";
  
  allDevices = lib.mapAttrs (_: v: {id = v.id; }) syncthingArgs;

  remoteDevices = lib.removeAttrs allDevices [ host ];

  remoteDeviceNames = builtins.attrNames remoteDevices;
in
{
  services.syncthing = {
    enable = true;

    user = userSettings.username;
    group = "users";

    dataDir = "/home/${userSettings.username}";
    configDir = "/home/${userSettings.username}/.config/syncthing";

    openDefaultPorts = true;

    settings = {
      options = {
        urAccepted = -1;
        localAnnounceEnabled = true;
        relaysEnabled = true;
        natEnabled = true;
      };

      devices = remoteDevices;

      folders = 
        lib.listToAttrs (map (dir: {
          name = dir;
          value = {
            path = "/home/${userSettings.username}/${dir}";
            devices = remoteDeviceNames;
          };
        }) syncDirs);
    };
  };
}