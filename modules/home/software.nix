{ pkgs, ... }:

{
  services.flatpak.enable = true;

  home.packages = with pkgs; [
    kdePackages.kate
    kdePackages.kwalletmanager
    nextcloud-client
    jellyfin-rpc
    anki
    obs-studio
    unrar
    drawio
    inkscape
    github-desktop
    spotify
    discord
    whatsapp-electron
  ];
}
