{ pkgs, homeConfigurations }:

let
  homeConfig = homeConfigurations.apaquette.config;
in
asserts: [
  (homeConfig.programs.firefox.enable)
]
