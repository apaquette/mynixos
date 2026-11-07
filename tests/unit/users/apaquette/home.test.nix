{ pkgs, homeConfigurations }:

let
  homeConfig = homeConfigurations.apaquette.config;
in
asserts: [
  (homeConfig.home.username == "apaquette")
  (homeConfig.home.homeDirectory == "/home/apaquette")
  (homeConfig.home.stateVersion == "25.11")
  (homeConfig.programs.fish.enable)
]
