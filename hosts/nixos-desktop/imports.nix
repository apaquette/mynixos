{
  config,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./raid.nix
    ./backup.nix
    ../../modules/gaming.nix
    ../../modules/software.nix
    ../../modules/kde.nix
    ../../modules/settings.nix
  ];
}