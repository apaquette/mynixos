{
  ...
}:
{
  boot.swraid = {
    enable = true;
    mdadmConf = ''
        DEVICE partitions
        ARRAY /dev/md0 metadata=1.2 UUID=06feb5d7:8068ed2e:0d93f17f:649590b9
        MAILADDR alexandre.d.paquette@gmail.com
      '';
  };
  
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