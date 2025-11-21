{ config, lib, ... }:
let
  zsh-custom = "${config.home.homeDirectory}/.zsh-custom";
in {
  programs.zsh = {
    enable = true;
    dotDir = zsh-custom;

    history = {
      size = 50000;
      save = 50000;
      path = "${zsh-custom}/.zsh_history";
      share = true;
      ignoreDups = true;
      ignoreSpace = true;
      extended = false;
    };

    autocd = false;
    syntaxHighlighting.enable = true;

    initContent = lib.mkOrder 1499 (builtins.readFile ./zshrc);

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
        "tmux"
        "yarn"
      ];
    };
  };
}
