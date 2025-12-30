{
  userSettings,
  ...
}:
{
  services.syncthing = {
    enable = true;

    user = "${userSettings.username}";
    group = "users";

    dataDir = "/home/${userSettings.username}";
    configDir = "/home/${userSettings.username}/.config/syncthing";

    openDefaultPorts = true;

    settings.options = {
      urAccepted = -1;
      localAnnounceEnabled = true;
      relaysEnabled = true;
      natEnabled = true;
    };
  };
}