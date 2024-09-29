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
            ./macos/hosts/sapokanikan/configuration
            ./macos/hosts/sapokanikan/configuration/macos-settings.nix
            home-manager-darwin.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.verbose = true;
              home-manager.users.joshua = {
                imports = [ ./macos/hosts/sapokanikan/home ];
              };
              home-manager.extraSpecialArgs = {
                inherit inputs system nixpkgs-unstable;
              };
            }
          ];
        };
      };

    lib = import ./lib.nix { inherit inputs; };

    nixosConfigurations =
      rec {
        ozymandian =
          self.lib.nixosSystem {
            system = "x86_64-linux";
            hostname = "ozymandian";
            ssh-identities = [ "joshua@ozymandian" ];
            inherit overlays;
          };

        meadowlark =
          self.lib.nixosSystem {
            system = "x86_64-linux";
            hostname = "meadowlark";
            ssh-identities = [ "joshua@meadowlark" ];
            inherit overlays;
          };

        neutrino = meadowlark; # stepping stone
      };
  };
}

