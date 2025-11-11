let
  pkgs = import <nixpkgs> {};
  # Fetch nix-flatpak
  nix-flatpak = pkgs.fetchFromGitHub {
    owner = "gmodena";
    repo = "nix-flatpak";
    rev = "62f636b87ef6050760a8cb325cadb90674d1e23e";  # Use the version you want
    hash = "sha256-0bBqT+3XncgF8F03RFAamw9vdf0VmaDoIJLTGkjfQZs=";
  };
in
{ config, pkgs, ... }:

{
  imports = [
    "${nix-flatpak}/modules/nixos.nix"
  ];
  # Install Flatpak
  services.flatpak = {
    enable = true;
    update.auto.enable = true;
    packages = [
      "org.gnome.Calculator"
      "com.ktechpit.whatsie"
    ];
  };

    environment.systemPackages = with pkgs; [
      spotify
      discord
      vlc
      flameshot # for screenshots
      obsidian
      webcamoid
      tribler # torrent
      # inkscape-with-extensions
      #LibreOffice
        libreoffice-qt6-fresh
        hunspell
        hunspellDicts.en_CA
  ];

}