{ ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.warn-dirty = false;
  nix.settings.auto-optimise-store = false;
  nix.settings.netrc-file = "/etc/nix/netrc";
  nix.settings.extra-sandbox-paths = [ "/etc/nix/netrc" ];

  nix.settings.substituters = [
    "https://cache.nixos.org"
    "https://nix-community.cachix.org"
    "https://onethirtyfive.cachix.org"
  ];

  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "onethirtyfive.cachix.org-1:w+zBnwl7vHfxNHawEN6Ej2zQ2ejgi8oqCxqVZ8wGYCg="
  ];
}
