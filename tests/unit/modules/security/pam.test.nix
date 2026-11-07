{ pkgs, nixosConfigurations }:

let
  desktopConfig = nixosConfigurations.nixos-desktop.config;
in
asserts: [
  (desktopConfig.security.pam.services.login.kwallet.enable)
]
