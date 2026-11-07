{ timezone, locale, ... }:

{
  time.timeZone = timezone;
  i18n.defaultLocale = locale;
  services.printing.enable = true;
}
