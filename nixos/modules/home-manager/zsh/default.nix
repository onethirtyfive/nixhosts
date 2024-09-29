let
  basis = ../../../../common/modules/home-manager/zsh;
in
  import basis { initExtra = builtins.readFile ./zshrc; }
