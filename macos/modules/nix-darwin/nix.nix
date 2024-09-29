{ pkgs, ... }:
{
  nix.package = pkgs.nixVersions.nix_2_22;
  nix.configureBuildUsers = true;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    warn-dirty = false;
    auto-optimise-store = false;

    netrc-file = "/etc/nix/netrc";

    extra-sandbox-paths = [
      "/etc/nix/netrc"
    ];

    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];

    trusted-users = [
      "@admin"
    ];
  };

  # Enable experimental nix command and flakes
  nix.extraOptions = ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';
}
