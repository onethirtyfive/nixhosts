# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{ pkgs, inputs, ... }:
let
  inherit (inputs) nixos-hardware;
in {
  imports =
    [
      ./hardware-configuration.nix
    ] ++ (with nixos-hardware.nixosModules; [
      common-cpu-amd
      common-gpu-amd
      common-pc-ssd
    ]) ++ (
      let
        inherit (builtins) map toPath;
        modules = [
          "audio.nix"
          "encrypted-zfs.nix"
          "firmware.nix"
          "fonts.nix"
          "gnome.nix"
          "locale.nix"
          "packages.nix"
        ];
      in
        map (module: toPath "${../../modules/system}/${module}") modules
    );

  hardware.enableAllFirmware = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings.General.Experimental = true; # for gnome-bluetooth percentage
  };

  boot.consoleLogLevel = 3;
  boot.tmp.cleanOnBoot = true;
  boot.supportedFilesystems = [ "zfs" "ntfs" ];

  boot.kernelParams = [
    "video=HDMI-A-1:3840x2160@60"
    "video=HDMI-A-2:3840x2160@60"
  ];

  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiInstallAsRemovable = true;
    efiSupport = true;
    useOSProber = true;
  };

  networking.hostName = "meadowlark";
  networking.hostId = "5e49a298";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    warn-dirty = false;

    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];

    trusted-users = [
      "@wheel"
    ];
  };

  security.polkit = {
    enable = true;
    debug = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  environment.systemPackages = [
    pkgs.microsoft-edge
  ];

  services = {
    xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];
    };
    printing.enable = true;
    flatpak.enable = true;
  };

  services.openssh.enable = true;
  services.keybase.enable = true;

  services.logind.extraConfig = ''
    HandlePowerKey=suspend
  '';

  virtualisation.docker.enable = true;

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11";
}

