{ pkgs, ... }:
{
  services.minecraft-server = {
    enable = true;
    eula = true;
    openFirewall = true; # Opens the port the server is running on (by default 25565 but in this case 43000)
    declarative = true;

    dataDir = "/var/lib/minecraft";

    whitelist = {
      # This is a mapping from Minecraft usernames to UUIDs. You can use https://mcuuid.net/ to get a Minecraft UUID for a username
      godlesscleric = "c63f635d-43cb-48de-8a6d-032203300cf5";
      elismart13 = "9603bf04-c7f4-4a08-a0c7-8cdd1ec41d51";
    };

    serverProperties = {
      level-name = "world";
      server-port = 43000;
      difficulty = "normal";
      gamemode = "survival";
      max-players = 5;
      motd = "Alex's NixOS Minecraft server!";
      white-list = true;
      allow-cheats = true;
    };

    jvmOpts = "-Xms2048M -Xmx4096M";
  };
}