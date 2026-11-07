{ ... }: {
  imports = [
    ../../modules/applications/git.nix
    ../../modules/home/software.nix
    ../../modules/applications/vscode.nix
    ../../modules/applications/nextcloud.nix
    ../../modules/applications/firefox.nix
    ../../modules/packages/flatpak.nix
    ./flatpaks.nix
  ];
}
