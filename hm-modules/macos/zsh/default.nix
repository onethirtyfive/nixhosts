{ lib, ... }:
{
  programs.zsh.initContent = lib.mkOrder 1500 (builtins.readFile ./zshrc);

  programs.zsh.shellAliases = {
    be = "bundle exec";
    bert = "bundle exec rake";
    gs = "git status";
    is = "env | grep -i in_nix_shell";
    nix = "noglob nix";
    rmswp = "find . -name *.swp | xargs rm";
    vim = "nvim";
  };
}
