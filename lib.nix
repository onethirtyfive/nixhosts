{ inputs, ... }:
let
  inherit (inputs) nixos-hardware home-manager nixpkgs;
in
{
  nixosSystem = {
    homedir ? "/home/joshua",
    system,
    hostname,
    ssh-identities,
    overlays,
  }:
  let
    system-imports = (with nixos-hardware.nixosModules; [
      common-cpu-amd
      common-gpu-amd
      common-pc-ssd
    ]) ++ (
      let
        inherit (builtins) map toPath;
        modulePaths = [
          "audio.nix"
          "encrypted-zfs.nix"
          "firmware.nix"
          "fonts.nix"
          "gnome.nix"
          "locale.nix"
          "mdns.nix"
          "nix.nix"
          "nixpkgs.nix"
          "packages.nix"
        ];
      in map (module: ./nixos/modules/system/${module}) modulePaths
    );

  home-manager-imports =
    let
      inherit (builtins) map toPath;
      modulePaths = [
        "zsh" # zsh/default.nix
        "alacritty.nix"
        "browser.nix"
        "dconf.nix"
        "direnv.nix"
        "env.nix"
        "git.nix"
        "gnome.nix"
        "meta.nix"
        "packages.nix"
        "services.nix"
        "ssh.nix"
        "starship.nix"
        "tmux.nix"
      ];
    in map (module: ./nixos/modules/home-manager/${module}) modulePaths;


  in nixpkgs.lib.nixosSystem {
    inherit system;

    modules = [
      {
        imports = system-imports ++ [
          ./nixos/hosts/${hostname}/hardware-configuration.nix
          ./nixos/hosts/${hostname}/configuration.nix
          ./nixos/modules/system/users/joshua.nix
        ];
      }
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          verbose = true;
          users.joshua = {
            imports = home-manager-imports;
          };
          extraSpecialArgs = {
            inherit inputs system nixpkgs;
            inherit homedir ssh-identities;
          };
        };
      }
    ];

    specialArgs = {
      inherit inputs overlays;
      nixpkgs = inputs.nixpkgs; # eg. not nixpkgs-darwin
    };
  };
}
