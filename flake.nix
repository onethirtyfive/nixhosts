{
  description = "All host configurations for Joshua's computers.";

  inputs = {
    systems.url = "github:nix-systems/default";

    # macos
    darwin.url = "github:lnl7/nix-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-darwin.follows = "darwin/nixpkgs";
    home-manager-darwin.url = "github:nix-community/home-manager";
    mac-app-util.url = "github:hraban/mac-app-util";
    mac-app-util.inputs.nixpkgs.follows = "nixpkgs-darwin";

    # linux
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.follows = "home-manager/nixpkgs";

    # common
    rust-overlay.url = "github:oxalica/rust-overlay";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    onethirtyfive-neovim.url = "github:onethirtyfive/neovim-nix";
    alacritty-theme.url = "github:alacritty/alacritty-theme";
    alacritty-theme.flake = false;
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  nixConfig = {
    extra-trusted-public-keys = ''
      nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=
      onethirtyfive.cachix.org-1:w+zBnwl7vHfxNHawEN6Ej2zQ2ejgi8oqCxqVZ8wGYCg=
    '';
    extra-substituters = ''
      https://nix-community.cachix.org
      https://onethirtyfive.cachix.org
    '';
  };

  outputs =
    inputs@{
      self,
      systems,

      # macos
      darwin,
      nixpkgs-darwin,
      home-manager-darwin,
      mac-app-util,

      # nixos
      nixpkgs,

      # common
      rust-overlay,
      onethirtyfive-neovim,
      treefmt-nix,
      ...
    }:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);

      inherit (nixpkgs.lib) hasSuffix;

      deriveInputs =
        system:
        if (hasSuffix system "-darwin") then
          {
            nixpkgs' = nixpkgs-darwin;
          }
        else
          {
            nixpkgs' = nixpkgs;
          };

      overlays = [
        rust-overlay.overlays.default
        onethirtyfive-neovim.overlays.default
        (import ./overlays/onethirtyfive)
      ];

      treefmtEval = forEachSystem (system:
        let
          inherit (deriveInputs system) nixpkgs';
          pkgs = nixpkgs'.legacyPackages.${system};
        in
        treefmt-nix.lib.evalModule pkgs ./treefmt.nix
      );
    in
    {
      formatter = forEachSystem (system: treefmtEval.${system}.config.build.wrapper);

      checks = forEachSystem (system: {
        formatting = treefmtEval.${system}.config.build.check self;
      });

      darwinConfigurations =
        let
          system = "aarch64-darwin";
          pkgs = import nixpkgs-darwin {
            inherit system overlays;
            config.allowUnfree = true;
          };
        in
        {
          futureproof = darwin.lib.darwinSystem {
            inherit pkgs;

            modules = [
              {
                imports =
                  [
                    ./hosts/futureproof/configuration.nix
                    ./hosts/futureproof/macos-settings.nix
                    ./hosts/futureproof/users/joshua.nix
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
                    (import ./hm-modules/common)
                    ++ (import ./hm-modules/macos)
                    ++ [ (import ./hosts/futureproof/home.nix) ];
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
          sapokanikan = darwin.lib.darwinSystem {
            inherit pkgs;

            modules = [
              {
                imports =
                  [
                    ./hosts/sapokanikan/configuration.nix
                    ./hosts/sapokanikan/macos-settings.nix
                    ./hosts/sapokanikan/users/joshua.nix
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
                    (import ./hm-modules/common)
                    ++ (import ./hm-modules/macos)
                    ++ [ (import ./hosts/sapokanikan/home.nix) ];
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

      nixosConfigurations = rec {
        ozymandian = self.lib.nixosSystem {
          system = "x86_64-linux";
          hostname = "ozymandian";
          ssh-identities = [ "joshua@ozymandian" ];
          inherit overlays;
        };

        meadowlark = self.lib.nixosSystem {
          system = "x86_64-linux";
          hostname = "meadowlark";
          ssh-identities = [ "joshua@meadowlark" ];
          inherit overlays;
        };

        neutrino = meadowlark; # stepping stone
      };

      devShells = forEachSystem (
        system:
        let
          inherit (deriveInputs system) nixpkgs';
          pkgs = nixpkgs'.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            name = "onethirtyfive-nixhosts-devshell";

            buildInputs = [
              pkgs.claude-code
            ];
          };
        }
      );

      packages = forEachSystem (_system: {
      });
    };
}
