{ pkgs, nixosConfigurations }:

let
  desktopConfig = nixosConfigurations.nixos-desktop.config;
in
asserts: [
  (builtins.length desktopConfig.security.pki.certificateFiles == 1)
]
