{ pkgs, ... }:
{
  programs.neovim.enable = true;
  programs.neovim.package = pkgs.onethirtyfive.neovim;
}
