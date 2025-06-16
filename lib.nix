{ inputs, ... }:
{
  nixosSystem =
    {
      homedir ? "/home/joshua",
      system,
      hostname,
      ssh-identities,
      overlays,
    }:
    let
      inherit (inputs) home-manager nixos-hardware;
    in
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        {
          imports =
            (with nixos-hardware.nixosModules; [
              common-cpu-amd
              common-gpu-amd
              common-pc-ssd
            ])
            ++ [
              ./hosts/${hostname}/configuration.nix
              ./hosts/${hostname}/hardware-configuration.nix
            ]
            ++ (import ./modules/common)
            ++ (import ./modules/nixos);

          nixpkgs.config.allowUnfree = true;
          nixpkgs.overlays = overlays;

          hardware.enableAllFirmware = true;
          hardware.bluetooth = {
            enable = true;
            powerOnBoot = false;
            settings.General.Experimental = true; # for gnome-bluetooth percentage
          };

          boot.consoleLogLevel = 3;
          boot.tmp.cleanOnBoot = true;
          boot.supportedFilesystems = [
            "zfs"
            "ntfs"
          ];

          boot.loader.grub = {
            enable = true;
            devices = [ "nodev" ];
            efiInstallAsRemovable = true;
            efiSupport = true;
            useOSProber = true;
          };

          networking.networkmanager.enable = true;
          networking.firewall.enable = false;

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

          services.openssh.enable = true;
          services.keybase.enable = true;

          services.logind.extraConfig = ''
            HandlePowerKey=suspend
          '';

          virtualisation.docker.enable = true;

          # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
          system.stateVersion = "23.11";
        }
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = false;
            useUserPackages = true;
            verbose = true;
            users.joshua = {
              imports = (import ./hm-modules/common) ++ (import ./hm-modules/nixos);
            };
            extraSpecialArgs = {
              inherit inputs homedir ssh-identities;
            };
          };
        }
      ];

      specialArgs = {
        inherit inputs;
      };
    };
}
