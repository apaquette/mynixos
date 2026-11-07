{ pkgs, nixosConfigurations }:

let
  desktopConfig = nixosConfigurations.nixos-desktop.config;
in
asserts: [
  (desktopConfig.networking.hostName == "nixos-desktop")
  (desktopConfig.networking.networkmanager.enable)
]
