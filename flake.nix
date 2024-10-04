{
  description = "All host configurations for Joshua's computers.";

  inputs = {
    # macos
    darwin.url = "github:lnl7/nix-darwin";
    nixpkgs-darwin.follows = "darwin/nixpkgs";
    home-manager-darwin.url = "github:nix-community/home-manager";
    home-manager-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";
    mac-app-util.url = "github:hraban/mac-app-util";
    mac-app-util.inputs.nixpkgs.follows = "nixpkgs-darwin";

    # linux
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.follows = "home-manager/nixpkgs";

    # common
    rust-overlay.url = "github:oxalica/rust-overlay";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    alacritty-theme.url = "github:alacritty/alacritty-theme";
    alacritty-theme.flake = false;
    onethirtyfive-neovim.url = "github:onethirtyfive/neovim-nix";
  };

  outputs = inputs@{
      self
    , nixpkgs-darwin
    , nixpkgs
    , darwin
    , home-manager
    , home-manager-darwin
    , mac-app-util
    , onethirtyfive-neovim
    , rust-overlay
    , nixos-hardware
    , ...
  }:
  let
    overlays = [
      rust-overlay.overlays.default
      onethirtyfive-neovim.overlays.default
      (import ./overlays/onethirtyfive)
    ];
  in  {
    nixConfig = {
      extra-trusted-public-keys = "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs= onethirtyfive.cachix.org-1:w+zBnwl7vHfxNHawEN6Ej2zQ2ejgi8oqCxqVZ8wGYCg=";
      extra-substituters = "https://nix-community.cachix.org https://onethirtyfive.cachix.org";
    };

    darwinConfigurations =
      let
        system = "aarch64-darwin";
        pkgs = import nixpkgs-darwin { inherit system overlays; };
      in {
        sapokanikan = darwin.lib.darwinSystem {
          inherit pkgs;

          modules = [
            {
              imports =
                [
                  ./hosts/sapokanikan/configuration.nix
                  ./hosts/sapokanikan/macos-settings.nix
                ]
                ++ (import ./modules/common)
                ++ (import ./modules/nix-darwin);

              nixpkgs.config.allowUnfree = true;
              nixpkgs.overlays = overlays;
            }
            home-manager-darwin.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.verbose = true;
              home-manager.sharedModules = [
                mac-app-util.homeManagerModules.default
              ];
              home-manager.users.joshua = {
                imports =
                  (import ./hm-modules/common) ++
                  (import ./hm-modules/macos);
              };
              home-manager.extraSpecialArgs = {
                inherit inputs system;
              };
            }
          ];

          specialArgs = {
            nixpkgs = inputs.nixpkgs-darwin;
          };
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

