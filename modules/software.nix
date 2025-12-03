{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
      kdePackages.kcalc # Calculator
      vlc
      flameshot # for screenshots
      obsidian
      webcamoid
      qbittorrent
      zip
      #LibreOffice
        libreoffice-qt6-fresh
        hunspell
        hunspellDicts.en_CA
  ];

}
