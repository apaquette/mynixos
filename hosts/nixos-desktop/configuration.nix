{ userSettings, ... }:

{
  networking.networkmanager.wifi.powersave = false;
  networking.enableIPv6 = false;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = userSettings.username;
}