{ host, timezone, locale, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = host;
  time.timeZone = timezone;
  i18n.defaultLocale = locale;
  programs.fish.enable = true;
}