{ config, ... }:
let
  cfg = config.programs.zsh;
in {
  config.programs.zsh.initExtra = cfg.initExtra ++ (builtins.readFile ./zshrc);
}
