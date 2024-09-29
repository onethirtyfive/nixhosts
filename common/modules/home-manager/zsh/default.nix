{
  initExtra ? "",
}:
{ ... }:
{
  programs.zsh = {
    enable = true;

    dotDir = ".zsh-custom";

    prezto = {
      enable = true;
      extraConfig = ''
        zstyle ':prezto:module:utility' safe-ops 'no'.
        zstyle ':completion:*' completer _expand _complete
      '';
    };

    autocd = false;
    syntaxHighlighting.enable = true;

    initExtra = ''
      ${builtins.readFile ./zshrc}
      ${initExtra}
    '';

    shellAliases = {
      gs = "git status";
    };

    oh-my-zsh = {
      plugins = [
        "aws"
        "bundler"
        "command-not-found"
        "direnv"
        "docker"
        "docker-compose"
        "fzf"
        "gitfast"
        "jira"
        "keychain"
        "kubectl"
        "minikube"
        "nmap"
        "ssh-agent"
        "sudo"
        "thefuck"
        "tmux"
        "yarn"
      ];
    };
  };
}

