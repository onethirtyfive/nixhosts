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
    # don't override its nixpkgs: it must track neovim-nightly-overlay's, or
    # neovim's lua env ends up with two conflicting luajits
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

      treefmtEval = forEachSystem (
        system:
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
            inherit system;
            config.allowUnfree = true;

            overlays = [
              onethirtyfive-neovim.overlays.default
            ];
          };

          hm-overlays = [
            rust-overlay.overlays.default
            onethirtyfive-neovim.overlays.default
            (import ./overlays/onethirtyfive)
            (final: prev: {
              claude-code =
                (import inputs.nixpkgs-unstable {
                  system = prev.system;
                  config.allowUnfree = true;
                }).claude-code;
            })
          ];
        in
        rec {
          grt-mbp =
            let
              primaryUser = "joshuamorris";
            in
            darwin.lib.darwinSystem {
              inherit pkgs;

              modules = [
                {
                  imports = [
                    ./hosts/grt-mbp/configuration.nix
                  ]
                  ++ (import ./modules/common)
                  ++ (import ./modules/nix-darwin);

                  nixpkgs.config.allowUnfree = true;
                  nixpkgs.overlays = hm-overlays;

                  system.primaryUser = primaryUser;
                  users.knownUsers = [ "codeparty" ];
                  users.knownGroups = [ "codepartyshare" ];
                  users.users.${primaryUser} = {
                    home = "/Users/${primaryUser}";
                    openssh.authorizedKeys.keys = [
                    ];
                  };
                  users.users.codeparty = {
                    description = "Code Party";
                    uid = 550;
                    home = "/Users/codeparty";
                    createHome = true;
                    shell = pkgs.bashInteractive;
                    packages = [ pkgs.tmux ];
                    openssh.authorizedKeys.keys = [
                      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICF9i4aasbPWmrG7d72JdElzJ2/01k00yX2sP+k8lqyP anahitgulian@kero.local"
                      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM3baklzEF1orS8G1o+tg0w5Pmqj5fPTp5gydWknR78F timothy.cummings@joingroups.com"
                      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBxMm9gg4ApGfbX9rMSBCwSUeXTAm6qpb8IZ2hoBpmtX sean.eshbaugh@joingroups.com"
                      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBA9311Ey6+O9l/mJOAS93H9JQLeBDd87twsZ8funCQC moorec104@gmail.com"
                      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHSyClVb2GhoHg3/UsoMGtwYhDgvpoBpXxXfed/2MFIp zstearman3@gmail.com"
                      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIiRe0k+C0skHnI/ZTN/HDo0qtfnCStc5dtm8kDmNIah pete.broderick@joingroups.com"
                    ];
                  };
                }
                home-manager-darwin.darwinModules.home-manager
                {
                  home-manager.useGlobalPkgs = false;
                  home-manager.useUserPackages = true;
                  home-manager.verbose = true;
                  home-manager.sharedModules = [
                    mac-app-util.homeManagerModules.default
                  ];
                  home-manager.users.joshuamorris = {
                    imports =
                      (import ./hm-modules/common)
                      ++ (import ./hm-modules/macos)
                      ++ [ (import ./hosts/grt-mbp/home.nix) ];

                    nixpkgs.config.allowUnfree = true;
                    nixpkgs.overlays = hm-overlays;
                  };
                  home-manager.extraSpecialArgs = {
                    inherit inputs system;
                    primaryUser = "joshua";
                  };
                }
              ];
            };

          futureproof =
            let
              primaryUser = "joshua";
            in
            darwin.lib.darwinSystem {
              inherit pkgs;

              modules = [
                {
                  imports = [
                    ./hosts/futureproof/configuration.nix
                  ]
                  ++ (import ./modules/common)
                  ++ (import ./modules/nix-darwin);

                  nixpkgs.config.allowUnfree = true;
                  nixpkgs.overlays = hm-overlays;

                  system.primaryUser = primaryUser;
                  users.users.${primaryUser} = {
                    home = "/Users/${primaryUser}";
                    openssh.authorizedKeys.keys = [
                    ];
                  };
                }
                home-manager-darwin.darwinModules.home-manager
                {
                  home-manager.useGlobalPkgs = false;
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

                    nixpkgs.config.allowUnfree = true;
                    nixpkgs.overlays = hm-overlays;
                  };
                  home-manager.extraSpecialArgs = {
                    inherit inputs system;
                    primaryUser = "joshua";
                  };
                }
              ];
            };

          sapokanikan = darwin.lib.darwinSystem {
            inherit pkgs;

            modules = [
              {
                imports = [
                  ./hosts/sapokanikan/configuration.nix
                  ./hosts/sapokanikan/users/joshua.nix
                ]
                ++ (import ./modules/common)
                ++ (import ./modules/nix-darwin);

                nixpkgs.config.allowUnfree = true;
                nixpkgs.overlays = hm-overlays;
              }
              home-manager-darwin.darwinModules.home-manager
              {
                home-manager.useGlobalPkgs = false;
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
          };
        };

      lib = import ./lib.nix { inherit inputs; };

      nixosConfigurations =
        let
          overlays = [
            onethirtyfive-neovim.overlays.default
          ];
        in
        rec {
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
          };
        }
      );

      packages = forEachSystem (_system: {
      });
    };
}
