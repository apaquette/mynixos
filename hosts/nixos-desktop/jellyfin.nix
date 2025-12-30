{
  pkgs,
  userSettings,
  ...
}:
{
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