{
  config,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./raid.nix
    ../../modules/gaming.nix
    ../../modules/software.nix
    ../../modules/kde.nix
    ../../modules/settings.nix
  ];
}