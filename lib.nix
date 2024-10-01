{ inputs, common, ... }:
{
  nixosSystem = {
    homedir ? "/home/joshua",
    system,
    hostname,
    ssh-identities,
    overlays,
  }:
  let
    inherit (inputs) home-manager nixpkgs;
  in inputs.nixpkgs.lib.nixosSystem {
    inherit system;

    modules = [
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          verbose = true;
          users.joshua = {
            imports =
              common.home-manager ++ [ ./nixos/home-manager ];
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
