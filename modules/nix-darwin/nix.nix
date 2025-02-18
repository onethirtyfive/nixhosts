{ pkgs, ... }:
{
  nix.package = pkgs.nixVersions.stable;
  nix.settings.sandbox = false;
  nix.settings.trusted-users = [ "@admin" ];

  # Enable experimental nix command and flakes
  nix.extraOptions = ''
    extra-platforms = aarch64-linux
  '';

  nix.linux-builder = {
    enable = true;
    ephemeral = true;
    maxJobs = 6;
    config = {
      virtualisation = {
        darwin-builder = {
          diskSize = 80 * 1024;
          memorySize = 16 * 1024;
        };
        cores = 6;
      };
    };
  };
}
