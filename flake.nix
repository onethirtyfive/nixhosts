{
  description = "Joshua's Hosts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    home.url = "path:./home";
    home.inputs.nixpkgs.follows = "nixpkgs";

    rust-overlay.url = "github:oxalica/rust-overlay";

    # https://discourse.nixos.org/t/how-to-get-codelldb-on-nixos/30401/5
    # lldb-nix-fix = {
    #   url = "github:mstone/nixpkgs/darwin-fix-vscode-lldb";
    # };
  };

  outputs = inputs@{ darwin, home-manager, nixpkgs, rust-overlay, ... }:
    let
      system = "aarch64-darwin";

      modules = [
        ./configuration
        ./configuration/macos-settings.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.verbose = true;
          home-manager.users.joshua = {
            imports = [ ./home ];
          };
          home-manager.extraSpecialArgs = { inherit nixpkgs system rust-overlay; };
        }
      ];
    in {
      darwinConfigurations = {
        thirdwave = darwin.lib.darwinSystem {
          inherit system modules inputs;
        };

        trendline = darwin.lib.darwinSystem {
          inherit system modules inputs;
        };
      };
  };
}

