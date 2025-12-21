{
  pkgs,
  userSettings,
  ...
}:
{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "${userSettings.username}";
  };

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];
}