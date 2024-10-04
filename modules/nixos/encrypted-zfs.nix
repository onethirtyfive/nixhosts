{ pkgs, ... }:
{
  # Changing this may render machine not-bootable.
  boot.kernelPackages = pkgs.linuxPackages_6_10;
  boot.zfs.requestEncryptionCredentials = true;

  services.zfs.autoScrub.enable = true;
}
