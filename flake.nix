{
  description = "All host configurations for Joshua's computers.";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin.url = "github:lnl7/nix-darwin";
    nixpkgs-darwin.follows = "darwin/nixpkgs";
    home-manager-darwin.url = "github:nix-community/home-manager";
    home-manager-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";

    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.follows = "home-manager/nixpkgs";

    rust-overlay.url = "github:oxalica/rust-overlay";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    alacritty-theme.url = "github:alacritty/alacritty-theme";
    alacritty-theme.flake = false;

    # This does not follow nixpkgs for now.
    onethirtyfive-neovim.url = "github:onethirtyfive/neovim-nix";
    # onethirtyfive-neovim.inputs.nixpkgs.follows = "nixpkgs";

    # https://discourse.nixos.org/t/how-to-get-codelldb-on-nixos/30401/5
    # lldb-nix-fix = {
    #   url = "github:mstone/nixpkgs/darwin-fix-vscode-lldb";
    # };
  };

  outputs = inputs@{
      self
    , nixpkgs-unstable
    , nixpkgs-darwin
    , nixpkgs
    , darwin
    , home-manager
    , home-manager-darwin
    , onethirtyfive-neovim
    , rust-overlay
    , nixos-hardware
    , ...
  }: let
    overlays = {
      onethirtyfive = (import ./overlays/onethirtyfive);
    };
  in {
    nixConfig = {
      extra-trusted-public-keys = "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs= onethirtyfive.cachix.org-1:w+zBnwl7vHfxNHawEN6Ej2zQ2ejgi8oqCxqVZ8wGYCg=";
      extra-substituters = "https://nix-community.cachix.org https://onethirtyfive.cachix.org";
    };

    darwinConfigurations =
      let
        system = "aarch64-darwin";
        pkgs = import nixpkgs-darwin {
          inherit system;

          overlays = [
            rust-overlay.overlays.default
            onethirtyfive-neovim.overlays.default
            overlays.onethirtyfive
          ];
        };
      in {
        sapokanikan = darwin.lib.darwinSystem {
          inherit pkgs;

          modules = [
            {
              system.stateVersion = 5;
            }
            ./hosts/macos/sapokanikan/configuration
            ./hosts/macos/sapokanikan/configuration/macos-settings.nix
            home-manager-darwin.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.verbose = true;
              home-manager.users.joshua = {
                imports = [ ./hosts/macos/sapokanikan/home ];
              };
              home-manager.extraSpecialArgs = {
                inherit inputs system nixpkgs-unstable;
              };
            }
          ];
        };
      };

    nixosConfigurations =
      let
        system = "x86_64-linux";
        homedir = "/home/joshua";

        system-imports = (with nixos-hardware.nixosModules; [
          common-cpu-amd
          common-gpu-amd
          common-pc-ssd
        ]) ++ (
          let
            inherit (builtins) map toPath;
            modulePaths = [
              "audio.nix"
              "encrypted-zfs.nix"
              "firmware.nix"
              "fonts.nix"
              "gnome.nix"
              "locale.nix"
              "nix.nix"
              "nixpkgs.nix"
              "packages.nix"
            ];
          in
            map (module: toPath "${./nixos/modules/system}/${module}") modulePaths
        );

        home-manager-imports =
          let
            inherit (builtins) map toPath;
            modulePaths = [
              "tmux" # tmux/default.nix
              "zsh" # zsh/default.nix
              "alacritty.nix"
              "browser.nix"
              "dconf.nix"
              "direnv.nix"
              "env.nix"
              "git.nix"
              "gnome.nix"
              "meta.nix"
              "packages.nix"
              "services.nix"
              "ssh.nix"
              "starship.nix"
            ];
          in map (module: toPath "${./nixos/modules/home-manager}/${module}") modulePaths;
      in rec {
        ozymandian = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            {
              imports = system-imports ++ [
                ./nixos/hosts/ozymandian/hardware-configuration.nix
                ./nixos/hosts/ozymandian/configuration.nix
                ./nixos/modules/system/users/joshua.nix
              ];
            }
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                verbose = true;
                users.joshua = {
                  imports = home-manager-imports;
                };
                extraSpecialArgs = {
                  inherit inputs system nixpkgs;
                  inherit homedir;
                  ssh-identities = [ "joshua@ozymandian" ];
                };
              };
            }
          ];
          specialArgs = { inherit inputs overlays; };
        };

        meadowlark = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            {
              imports = system-imports ++ [
                ./nixos/hosts/meadowlark/hardware-configuration.nix
                ./nixos/hosts/meadowlark/configuration.nix
                ./nixos/modules/system/users/joshua.nix
              ];
            }
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                verbose = true;
                users.joshua = {
                  imports = home-manager-imports;
                };
                extraSpecialArgs = {
                  inherit inputs system nixpkgs;
                  inherit homedir;
                  ssh-identities = [ "joshua@meadowlark" ];
                };
              };
            }
          ];
          specialArgs = { inherit inputs overlays; };
        };

        neutrino = meadowlark; # stepping stone
      };
  };
}

