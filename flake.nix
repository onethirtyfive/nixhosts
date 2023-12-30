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

    alacritty-theme = {
      url = "github:alacritty/alacritty-theme";
      flake = false;
    };

    hyprland.url = "github:hyprwm/Hyprland";

    # https://discourse.nixos.org/t/how-to-get-codelldb-on-nixos/30401/5
    # lldb-nix-fix = {
    #   url = "github:mstone/nixpkgs/darwin-fix-vscode-lldb";
    # };
  };

  outputs = inputs@{ nixpkgs-unstable, nixpkgs, darwin, home-manager, rust-overlay, alacritty-theme, ... }: {
    darwinConfigurations =
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
            home-manager.extraSpecialArgs = { inherit system nixpkgs-unstable rust-overlay; };
          }
        ];
      in {
        thirdwave = darwin.lib.darwinSystem {
          inherit system modules inputs;
        };

        trendline = darwin.lib.darwinSystem {
          inherit system modules inputs;
        };
      };

    nixosConfigurations =
      let
        system = "x86_64-linux";
        joshua = import ./users/joshua;
      in {
        neutrino = nixpkgs.lib.nixosSystem {
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
                extraSpecialArgs = { inherit system nixpkgs rust-overlay alacritty-theme; };
              };
            }
            (import ./hosts/neutrino)
          ];
          specialArgs = { inherit inputs; };
        };
      };
  };
}

