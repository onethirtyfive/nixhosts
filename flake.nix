{
  description = "Joshua's Hosts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ home-manager, darwin, ... }:
    let
      home-manager-defaults = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
	home-manager.verbose = true;
        home-manager.users.joshua = {
          imports = [ ./home ];
        };
      };

      modules = [
        ./configuration
        ./configuration/macos-settings.nix
        home-manager.darwinModules.home-manager
        home-manager-defaults
      ];
    in {
      darwinConfigurations = {
        thirdwave = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          inherit modules;
        };

        trendline = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          inherit modules;
        };
      };
  };
}

