{
  config,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/software.nix
    ../../modules/kde.nix
  ];
}
