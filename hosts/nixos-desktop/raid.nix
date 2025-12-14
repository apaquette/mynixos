{
  ...
}:
{
  boot.swraid.enable = true;

  # Mount drive configuration
  fileSystems."mnt/myraid" = {
    device = "/dev/disk/by-uuid/f316b340-b988-4306-8164-9f7d11250a55";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  # Mount backup drive
  fileSystems."/mnt/backup" = { 
    device = "/dev/disk/by-uuid/D8161297161276AA";
    fsType = "ntfs";
    options = [ "nofail" ];
  };
}