# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{ pkgs, inputs, ... }:
{
  imports =
    let
      bespoke-nixos-modules = import ../../modules/nixos;
    in [ ./hardware-configuration.nix ] ++
      (map
        (path: import path)
        (builtins.attrValues bespoke-nixos-modules));

  hardware.enableAllFirmware = true;

  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiInstallAsRemovable = true;
    efiSupport = true;
    useOSProber = true;
  };

  networking.hostName = "neutrino";
  networking.hostId = "5e49a298";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    warn-dirty = false;
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    inputs.rust-overlay.overlays.default
    (import ./overlay)
  ];

  security.polkit = {
    enable = true;
    debug = true;
  };

  services.openssh.enable = true;
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.keybase.enable = true;

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11";
}

