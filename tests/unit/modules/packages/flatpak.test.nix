{ pkgs, homeConfigurations }:

let
  homeConfig = homeConfigurations.apaquette.config;
in
asserts: [
  (homeConfig.services.flatpak.enable)
]
