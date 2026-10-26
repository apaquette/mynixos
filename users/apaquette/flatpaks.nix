{ ... }:

{
  services.flatpak = {
    enable = true;

    packages = [
      {
        appId = "ai.storyteller.photocraft";
        bundle = "file://${../../flatpaks/photocraft-0.5.0-linux-x86_64.flatpak}";
        sha256 = "sha256-lYKubS66svupb4Wa52AZvy8FLVWqlVKR9sUpcWUdfcw=";
      }
      {
        appId = "ai.storyteller.filmcraft";
        bundle = "file://${../../flatpaks/filmcraft-0.13.0-linux-x86_64.flatpak}";
        sha256 = "sha256-yabHY7v2v06maiBPVkU5LOo5/punTwiLDAgUnEltoaA=";
      }
    ];
  };
}