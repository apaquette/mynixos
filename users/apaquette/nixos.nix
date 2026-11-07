{ pkgs, username, userSettings, ... }:

{
  users.users.${username} = {
    isNormalUser = true;
    description = "${userSettings.name} (${userSettings.email})";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
    createHome = true;
  };
}