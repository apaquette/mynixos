{ pkgs, nixosConfigurations }:

let
  desktopConfig = nixosConfigurations.nixos-desktop.config;
in
asserts: [
  (desktopConfig.services.displayManager.sddm.enable)
  (desktopConfig.services.displayManager.autoLogin.enable)
  (desktopConfig.services.displayManager.autoLogin.user == "apaquette")
]
