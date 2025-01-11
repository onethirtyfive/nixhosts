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
    macos-config.url = "github:mrkuz/macos-config";

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

  nixConfig = {
    extra-trusted-public-keys = ''
      nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=
      onethirtyfive.cachix.org-1:w+zBnwl7vHfxNHawEN6Ej2zQ2ejgi8oqCxqVZ8wGYCg=
      devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
    '';
    extra-substituters = ''
      https://nix-community.cachix.org
      https://onethirtyfive.cachix.org
      https://devenv.cachix.org
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
      devenv-darwin,
      macos-config,

      # nixos
      nixpkgs,
      devenv,

      # common
      rust-overlay,
      onethirtyfive-neovim,
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
            devenv' = devenv-darwin;
          }
        else
          {
            nixpkgs' = nixpkgs;
            devenv' = devenv;
          };

      overlays = [
        rust-overlay.overlays.default
        onethirtyfive-neovim.overlays.default
        (import ./overlays/onethirtyfive)
        (
          _: _:
          let
            root = macos-config.packages.aarch64-darwin;
          in
          {
            macos.socket_vmnet = root.macos.socket_vmnet;
          }
        )
      ];
    in
    {
      darwinConfigurations =
        let
          system = "aarch64-darwin";
          pkgs = import nixpkgs-darwin { inherit system overlays; };
        in
        {
          sapokanikan = darwin.lib.darwinSystem {
            inherit pkgs;

            modules = [
              {
                imports = [
                  ./hosts/sapokanikan/configuration.nix
                  ./hosts/sapokanikan/macos-settings.nix
                  ./hosts/sapokanikan/users/joshua.nix
                  "${macos-config}/modules/darwin/socket-vmnet.nix"
                ] ++ (import ./modules/common) ++ (import ./modules/nix-darwin);

                modules.socketVmnet.enable = true;

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
          inherit (deriveInputs system) nixpkgs' devenv';

          pkgs = import nixpkgs' {
            overlays = [
              (_: _: {
                devenv = devenv'.packages.${system}.default;
              })
            ];
          };
        in
        {
          default = devenv'.lib.mkShell {
            inherit inputs pkgs;
            modules = [ ./devenv.nix ];
          };
        }
      );

      packages = forEachSystem (system: {
        devenv-up = self.devShells.${system}.default.config.procfileScript;
      });
    };
}
