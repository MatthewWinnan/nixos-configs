# Partition and mount the disk with a LUKS-encrypted Btrfs filesystem using disko
#
# Run this in the terminal:
# DISK='/dev/disk/by-id/ata-Samsung_SSD_870_EVO_250GB_S6PENL0T902873K'
# sed -i "s|/dev/disk/by-id/ata-CT500MX500SSD1_1804E10BA2D6|$DISK|" /tmp/disko.nix
# nix --experimental-features "nix-command flakes" run github:nix-community/disko \
#     -- --mode disko /tmp/disko.nix
#
# I had to hard code the sector values, make sure the disk is at least 10GB...
{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi0";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              start = "1M";
              end = "1G";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            plainSwap = {
              start = "2097153";
              end = "18874367";
              content = {
                type = "swap";
                discardPolicy = "both";
                resumeDevice = true; # resume from hiberation from this device
              };
            };
            root = {
              start = "18874368";
              # For a 256 disk using 512 byte sectors
              end = "534775740";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
