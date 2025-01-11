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

  # Auto-upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
}
