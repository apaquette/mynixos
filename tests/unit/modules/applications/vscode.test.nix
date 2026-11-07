{ pkgs, homeConfigurations }:

let
  homeConfig = homeConfigurations.apaquette.config;
in
asserts: [
  (homeConfig.programs.vscode.enable)
  (homeConfig.programs.vscode.package == pkgs.vscode.fhs)
]
