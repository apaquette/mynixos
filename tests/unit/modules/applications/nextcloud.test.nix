{ pkgs, homeConfigurations }:

let
  homeConfig = homeConfigurations.apaquette.config;
in
asserts: [
  (builtins.hasAttr "nextcloud-client" homeConfig.systemd.user.services)
]
