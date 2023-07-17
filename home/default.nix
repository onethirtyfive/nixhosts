{ nixpkgs, system, ... }:
let
  pkgs' = import nixpkgs {
    inherit system;
    overlays = [ (import ./overlay) ];

    config.permittedInsecurePackages = [
      "nodejs-16.20.1"
    ];
  };

  inherit (pkgs') stdenv;
in {
  imports =
    let
      withCustomPkgs = path: import path pkgs';
      paths = [
        ./alacritty
        ./darwin-application-activation
        ./git
        ./neovim
        ./nushell
        ./zsh
      ];
    in map withCustomPkgs paths;

  home.packages = (with pkgs'; [
    curl
    fd
    lazydocker
    less
    ripgrep
  ]) ++ (with pkgs'.joshua; [ cc2538-bsl python311 ruby_3_1 ]);

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

