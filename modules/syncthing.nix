{
  ...
}:
{
  services.syncthing = {
    enable = true;

    user = "apaquette";
    group = "users";

    dataDir = "/home/apaquette";
    configDir = "/home/apaquette/.config/syncthing";

    openDefaultPorts = true;

    settings = {
      options = {
        localAnnounceEnabled = true;
        relaysEnabled = true;
        natEnabled = true;
      };
    };
  };
}