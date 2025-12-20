{ 
  config,
  pkgs,
  userSettings,
  ... 
}:

{
  # Mount backup drive
  fileSystems."/mnt/backup" = { 
    device = "/dev/disk/by-uuid/2f26abd3-1603-4c8d-890c-a8a8aea9c5f1";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  ## Borg backup service
  services.borgbackup.jobs.system-backup = {
    encryption.mode = "none";

    paths = [
      "/home/${userSettings.username}/Documents"
      "/home/${userSettings.username}/Pictures"
      "/mnt/myraid/Audiobooks"
      "/mnt/myraid/Emulators"
      #"/mnt/myraid/Videos"
    ];

    # patterns = [
    #   "+ /mnt/myraid/Videos/**/*.avi"
    #   "+ /mnt/myraid/Videos/**/*.mkv"
    #   "+ /mnt/myraid/Videos/**/*.mp4"

    #   "- /mnt/myraid/Videos/**"
    # ];

    repo = "/mnt/backup/borg";
    compression = "auto,zstd";
    startAt = "daily";

    prune.keep = {
      daily = 7;
      weekly = 4;
      monthly = 6;
    };
  };

  # rsync backup service
  # systemd.services.media-backup = {
  #   after = [ "mnt-backup.mount" ];
  #   requires = [ "mnt-backup.mount" ];

  #   serviceConfig = {
  #     Type = "oneshot";
  #     User = "root";

  #     ExecStart = ''
  #       ${pkgs.rsync}/bin/rsync -a \
  #         --delete \
  #         --prune-empty-dirs \
  #         --numeric-ids \
  #         --info=stats2 \
  #         --include='*/' \
  #         --include='*.mkv' \
  #         --include='*.mp4' \
  #         --include='*.avi' \
  #         --include='*.mov' \
  #         --include='*.m4v' \
  #         --include='*.webm' \
  #         --include='*.srt' \
  #         --include='*.ass' \
  #         --include='*.ssa' \
  #         --include='*.sub' \
  #         --include='*.vtt' \
  #         --include='*.idx' \
  #         --include='*.sup' \
  #         --exclude='*' \
  #         /mnt/myraid/Videos/ \
  #         /mnt/backup/Videos/
  #     '';
  #   };
  # };

  # systemd.timers.media-backup = {
  #   wantedBy = [ "timers.target" ];

  #   timerConfig = {
  #     OnCalendar = "daily";
  #     Persistent = true;
  #   };
  # };
}