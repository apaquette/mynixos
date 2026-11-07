{
  config,
  ...
}:
{
  imports = [
    ../common/imports.nix
    ./hardware-configuration.nix
    ../../modules/gaming.nix
    ../../modules/kde.nix
    ../../modules/settings.nix
    ../../modules/local-ai.nix
  ];
}