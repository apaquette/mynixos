{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pciutils
    mdadm
    kdePackages.kcalc
    kdePackages.ktorrent
    kdePackages.kamoso
    vlc
    obsidian
    zip
    onlyoffice-desktopeditors
    iw
  ];
}
