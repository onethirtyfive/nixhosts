{ pkgs, ... }:
{
  imports = [
    ./git
    ./zsh
    ./nushell
    ./alacritty
    ./neovim
    ./darwin-application-activation
  ];

  home.packages = with pkgs; [
    ripgrep
    fd
    curl
    less
    onethirtyfive-dev-python # from host config
  ];

  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
  };

  # shells
  programs.starship.enable = true;

  # quality of life
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.exa.enable = true;
  programs.fzf.enable = true;

  # dependencies
  programs.texlive.enable = true; # scapy runtime dep (shellout)

  home.stateVersion = "22.11"; # rarely changed
}

