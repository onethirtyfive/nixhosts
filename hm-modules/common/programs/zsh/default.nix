{ lib, ... }:
{
  programs.zsh.enable = true;

  programs.zsh.dotDir = ".zsh-custom";

  programs.zsh.autocd = false;
  programs.zsh.syntaxHighlighting.enable = true;

  programs.zsh.initContent = lib.mkOrder 1499 (builtins.readFile ./zshrc);

  programs.zsh.shellAliases = {
    gs = "git status";
  };

  programs.zsh.oh-my-zsh = {
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
}
