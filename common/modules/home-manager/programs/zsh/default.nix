{ lib, ... }:
{
  programs.zsh.enable = true;

  programs.zsh.dotDir = ".zsh-custom";

  programs.zsh.prezto = {
    enable = true;
    extraConfig = ''
      zstyle ':prezto:module:utility' safe-ops 'no'.
      zstyle ':completion:*' completer _expand _complete
    '';
  };

  programs.zsh.autocd = false;
  programs.zsh.syntaxHighlighting.enable = true;

  programs.zsh.initExtra =
    let
      zshrc = builtins.readFile ./zshrc;
    in lib.mkMerge (lib.splitString "\n" zshrc);

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
