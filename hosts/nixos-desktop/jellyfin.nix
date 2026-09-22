{
  pkgs,
  userSettings,
  ...
}:
{
  users.groups.media = {
    gid = 1000;
  };
  users.users.${userSettings.username}.extraGroups = [ "media" ];
  users.users.qbittorrent.extraGroups = [ "media" ];
  users.users.radarr.extraGroups = [ "media" ];
  users.users.sonarr.extraGroups = [ "media" ];

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    jellyseerr
  ];

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "${userSettings.username}";
  };

  services.jellyseerr = {
    enable = true;
    openFirewall = true;
  };

  services.radarr = {
    enable = true;
    openFirewall = false;
  };

  services.sonarr = {
    enable = true;
    openFirewall = false;
  };

  services.prowlarr = {
    enable = true;
    openFirewall = false;
  };

  services.qbittorrent = {
    enable = true;
    openFirewall = true;
    webuiPort = 8080;
  };
}