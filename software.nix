{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
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
