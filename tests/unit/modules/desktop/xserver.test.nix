{ pkgs, nixosConfigurations }:

let
  desktopConfig = nixosConfigurations.nixos-desktop.config;
in
asserts: [
  (desktopConfig.services.xserver.enable)
  (desktopConfig.services.xserver.xkb.layout == "us")
  (desktopConfig.services.xserver.xkb.variant == "colemak")
  (desktopConfig.services.xserver.xkb.options == "caps:backspace")
]
