pkgs:
{ ... }:
{
  programs.zsh = {
    enable = true;
    prezto = {
      enable = true;
      extraConfig = ''
        zstyle ':prezto:module:utility' safe-ops 'no'.
      '';
    };

    autocd = true;
    syntaxHighlighting.enable = true;
    initExtra = builtins.readFile ./zshrc;

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
        "git"
        "git-lfs"
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

