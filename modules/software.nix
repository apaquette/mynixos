{ ... }:

{
  nixpkgs.config = {
    allowUnfree = true;

    permittedInsecurePackages = [
      "electron-39.8.10"
    ];
  };

  services.flatpak.enable = true;
}