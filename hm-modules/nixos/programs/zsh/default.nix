{ lib, ... }:
{
  programs.zsh.initContent = lib.mkOrder 1499 (builtins.readFile ./zshrc);
}
