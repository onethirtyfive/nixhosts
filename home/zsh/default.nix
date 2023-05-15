{ ... }:
{
  programs.zsh = {
    enable = true;
    prezto.enable = true;

    autocd = true;
    enableSyntaxHighlighting = true;
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

