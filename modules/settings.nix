{  pkgs, host, timezone, locale, ... }:

{
    hardware.bluetooth.enable = true;
    networking.hostName = host;
    networking.networkmanager.enable = true;
    time.timeZone = timezone;
    i18n.defaultLocale = locale;
    services.printing.enable = true;
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    system.autoUpgrade = {
      enable = true;
      dates = "weekly";
    };

    environment.shells = with pkgs; [ fish ];
    users.defaultUserShell = pkgs.fish;
    programs.fish.enable = true;
}