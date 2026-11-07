{ pkgs, nixosConfigurations }:

let
  desktopConfig = nixosConfigurations.nixos-desktop.config;
in
asserts: [
  (desktopConfig.time.timeZone == "America/Halifax")
  (desktopConfig.i18n.defaultLocale == "en_CA.UTF-8")
  (desktopConfig.services.printing.enable)
]
