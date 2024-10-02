{ pkgs, ... }:
{
  nix.package = pkgs.nixVersions.nix_2_22;
  nix.configureBuildUsers = true;
  nix.settings.sandbox = false;
  nix.settings.trusted-users = [ "@admin" ];

  # Enable experimental nix command and flakes
  nix.extraOptions = ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  nix.linux-builder = {
    enable = true;
    maxJobs = 4;
    config = {
      virtualisation = {
        darwin-builder = {
          diskSize = 40 * 1024;
          memorySize = 16 * 1024;
        };
        cores = 6;
      };
    };
  };
}
