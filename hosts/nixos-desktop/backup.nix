{ ... }:

{
  # Mount backup drive
  fileSystems."/mnt/backup" = { 
    device = "/dev/disk/by-uuid/2f26abd3-1603-4c8d-890c-a8a8aea9c5f1";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  services.borgbackup.jobs.system-backup = {
    encryption.mode = "none";

    paths = [
      "/home/apaquette/Documents"
      "/home/apaquette/Pictures"
      "/mnt/myraid/Audiobooks"
      "/mnt/myraid/Emulators"
      "/mnt/myraid/Videos"
    ];

    repo = "/mnt/backup/borg";
    compression = "auto,zstd";
    startAt = "daily";

    prune.keep = {
      daily = 7;
      weekly = 4;
      monthly = 6;
    };
  };
}