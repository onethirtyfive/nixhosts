{ inputs, nixpkgs, system, ... }:
let
  pkgs = import nixpkgs {
    inherit system;

    overlays = [
      rust-overlay.overlays.default
      (import ./overlay {})
    ];

    permittedInsecurePackages = [ "nodejs-16.20.2" ];

    config = {
      allowUnfree = true;
    };
  };

  inherit (inputs) rust-overlay;
in {
  imports =
    let
      paths = builtins.attrValues (import ../../home-manager);
    in map (path: import path pkgs) paths;

  home.packages = (with pkgs; [
    curl
    fd
    lazydocker
    less
    ripgrep
    coreutils
    gnused
    home-manager
    pinentry
    pkgs.rust-bin.stable.latest.complete
  ]) ++ (with pkgs.joshua; [ cc2538-bsl python311 ]);

  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

  # one-off enables for joshua
  programs.starship.enable = true;
  programs.eza.enable = true;
  programs.fzf.enable = true;
  programs.texlive.enable = true; # scapy runtime dep (shellout)

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "23.11"; # rarely changed
}

