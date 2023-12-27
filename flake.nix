{
  description = "All host configurations for Joshua's computers.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    rust-overlay.url = "github:oxalica/rust-overlay";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # https://discourse.nixos.org/t/how-to-get-codelldb-on-nixos/30401/5
    # lldb-nix-fix = {
    #   url = "github:mstone/nixpkgs/darwin-fix-vscode-lldb";
    # };
  };

  outputs = inputs@{ nixpkgs-unstable, darwin, home-manager, rust-overlay, ... }:
    let
      system = "aarch64-darwin";

      modules = [
        ./legacy/configuration
        ./legacy/configuration/macos-settings.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.verbose = true;
          home-manager.users.joshua = {
            imports = [ ./legacy/home ];
          };
          home-manager.extraSpecialArgs = { inherit nixpkgs-unstable system rust-overlay; };
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

