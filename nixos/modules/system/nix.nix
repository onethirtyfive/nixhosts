let
  basis = ../../../common/modules/system/nix.nix;
in
{ nixpkgs, ... }@args:
let
  module = import basis {
    extraConfig = {
      nix.package = nixpkgs.legacyPackages.x86_64-linux.nixVersions.nix_2_22;
      nix.settings.sandbox = false;
      nix.settings.trusted-users = [ "@wheel" ];
    };
  };
in
module args
