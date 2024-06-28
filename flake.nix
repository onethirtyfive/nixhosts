{
  description = "All host configurations for Joshua's computers.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    rust-overlay.url = "github:oxalica/rust-overlay";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    alacritty-theme = {
      url = "github:alacritty/alacritty-theme";
      flake = false;
    };

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
    , onethirtyfive-neovim
    , ...
  }: let
    modules = import ./modules;
    overlays = import ./overlays;
  in {
    darwinConfigurations =
      let
        system = "aarch64-darwin";
      in {
        sapokanikan = darwin.lib.darwinSystem {
          inherit system inputs;

          modules = [
            ./hosts/macos/sapokanikan/configuration
            ./hosts/macos/sapokanikan/configuration/macos-settings.nix
            home-manager.darwinModules.home-manager
            {
              nix.registry.nixpkgs.flake = inputs.nixpkgs-darwin;
            }
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
        joshua = import ./users/joshua;

        bespoke = { inherit modules overlays; };
      in rec {
        ozymandian = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            joshua.system-user
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                verbose = true;
                users.joshua = joshua.managed-home;
                extraSpecialArgs = {
                  inherit inputs system nixpkgs;
                  inherit homedir;
                  ssh-identities = [ "joshua@ozymandian" ];
                };
              };
            }
            (import ./hosts/nixos/ozymandian)
          ];
          specialArgs = { inherit inputs bespoke; };
        };

        meadowlark = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            joshua.system-user
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                verbose = true;
                users.joshua = joshua.managed-home;
                extraSpecialArgs = {
                  inherit inputs system nixpkgs;
                  inherit homedir;
                  ssh-identities = [ "joshua@meadowlark" ];
                };
              };
            }
            (import ./hosts/nixos/meadowlark)
          ];
          specialArgs = { inherit inputs bespoke; };
        };

        neutrino = meadowlark; # stepping stone
      };
  };
}

