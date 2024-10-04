{
  description = "All host configurations for Joshua's computers.";

  inputs = {
    systems.url = "github:nix-systems/default";

    # macos
    darwin.url = "github:lnl7/nix-darwin";
    nixpkgs-darwin.follows = "darwin/nixpkgs";
    home-manager-darwin.url = "github:nix-community/home-manager";
    home-manager-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";
    mac-app-util.url = "github:hraban/mac-app-util";
    mac-app-util.inputs.nixpkgs.follows = "nixpkgs-darwin";
    devenv-darwin.url = "github:cachix/devenv";
    devenv-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";

    # linux
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.follows = "home-manager/nixpkgs";
    devenv.url = "github:cachix/devenv";
    devenv.inputs.nixpkgs.follows = "nixpkgs";

    # common
    rust-overlay.url = "github:oxalica/rust-overlay";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    onethirtyfive-neovim.url = "github:onethirtyfive/neovim-nix";
    alacritty-theme.url = "github:alacritty/alacritty-theme";
    alacritty-theme.flake = false;
  };

  outputs = inputs@{
      self
    , systems

    # macos
    , darwin
    , nixpkgs-darwin
    , home-manager-darwin
    , mac-app-util
    , devenv-darwin

    # nixos
    , nixpkgs
    , devenv

    # common
    , rust-overlay
    , nixos-hardware
    , onethirtyfive-neovim
    , ...
  }:
  let
    forEachSystem = nixpkgs.lib.genAttrs (import systems);

    overlays = [
      rust-overlay.overlays.default
      onethirtyfive-neovim.overlays.default
      (import ./overlays/onethirtyfive)
    ];
  in  {
    nixConfig = {
      extra-trusted-public-keys = "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs= onethirtyfive.cachix.org-1:w+zBnwl7vHfxNHawEN6Ej2zQ2ejgi8oqCxqVZ8wGYCg= devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
      extra-substituters = "https://nix-community.cachix.org https://onethirtyfive.cachix.org https://devenv.cachix.org";
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

    packages = forEachSystem (system: {
      devenv-up = self.devShells.${system}.default.config.procfileScript;
    });

    devShells = forEachSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = devenv.lib.mkShell {
            inherit inputs pkgs;
            modules = [
              {
                # https://devenv.sh/reference/options/
                packages = [ pkgs.hello ];

                enterShell = ''
                  hello
                '';

                processes.hello.exec = "hello";
              }
            ];
          };
        });
  };
}

