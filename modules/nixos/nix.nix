{ pkgs, ... }:
{
  nix.package = pkgs.nixVersions.nix_2_22;
  nix.settings.trusted-users = [ "@wheel" ];
}
