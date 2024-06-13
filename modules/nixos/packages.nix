{ pkgs, ... }:
{
  # available universally on machine
  environment.systemPackages = with pkgs; [
    git
    wget
    tree
    curl
    home-manager
  ];
}
