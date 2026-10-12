
{ pkgs, userSettings, ... }:

{
  users.users.${userSettings.username} = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = userSettings.name;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
