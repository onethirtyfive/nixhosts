pkgs:
{ ... }:
{
  programs.zsh = {
    enable = true;
    prezto.enable = true;

    autocd = true;
    syntaxHighlighting.enable = true;
    initExtra = builtins.readFile ./zshrc;

    shellAliases = {
      gs = "git status";
    };

    oh-my-zsh = {
      plugins = [
        "git"
      ];
    };
  };
}

