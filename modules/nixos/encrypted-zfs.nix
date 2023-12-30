{ config, ... }:
{
  # Ensure kernel can boot at all: ZFS versions lag a bit due to licensing.
  # Changing this may render machine not-bootable.
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages; # invariant
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.requestEncryptionCredentials = true;

  services.zfs.autoScrub.enable = true;
}

