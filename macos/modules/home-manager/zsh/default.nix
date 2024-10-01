{ config, ... }:
let
  cfg = config.programs.zsh;
in
{
  programs.zsh.initExtra = cfg.initExtra ++ (builtins.readFile ./zshrc);
}
