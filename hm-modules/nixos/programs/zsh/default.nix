{ lib, ... }:
{
  programs.zsh.initExtra =
    let
      zshrc = builtins.readFile ./zshrc;
    in
    lib.mkMerge (lib.splitString "\n" zshrc);
}
