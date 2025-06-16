
{ pkgs, ... }:
{
  enableDefaultExcludes = true;

  projectRootFile = "flake.nix";

  programs.nixfmt.enable = true;
  programs.nixfmt.includes = [ "*.nix" ];

  programs.shfmt.enable = true;

  settings.formatter = {
  };
}
