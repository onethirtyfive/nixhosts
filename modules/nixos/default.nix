{
  audio = import ./audio.nix;
  encrypted-zfs = import ./encrypted-zfs.nix;
  firmware = import ./firmware.nix;
  fonts = import ./fonts.nix;
  gnome = import ./gnome.nix;
  locale = import ./locale.nix;
  packages = import ./packages.nix;
}

