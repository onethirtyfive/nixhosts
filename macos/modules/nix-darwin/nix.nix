let
  basis = ../../../common/modules/system/nix.nix;
in
{ nixpkgs, ... }@args:
let
  module = import basis {
    extraConfig = {
      nix.package = nixpkgs.legacyPackages.aarch64-darwin.nixVersions.nix_2_22;

      nix.settings.sandbox = false;
      nix.configureBuildUsers = true;
      nix.settings.trusted-users = [ "@admin" ];

      # Enable experimental nix command and flakes
      nix.extraOptions = ''
        extra-platforms = x86_64-darwin aarch64-darwin
      '';
    };
  };
in
module args
