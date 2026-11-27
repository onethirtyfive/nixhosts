{ pkgs, ... }:
{
  fonts.packages = [
    pkgs.nerd-fonts.atkynson-mono
    pkgs.nerd-fonts.caskaydia-cove
    pkgs.nerd-fonts.intone-mono
  ];
}
