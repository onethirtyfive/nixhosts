{ lib, ... }:
{
  programs.zsh.initContent =
    let
      zshrc = builtins.readFile ./zshrc;
    in
    lib.mkMerge (lib.splitString "\n" zshrc);
}
