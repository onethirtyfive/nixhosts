{ pkgs, ... }:
{
  imports =
    let
      bespoke-home-manager-modules = import ../../modules/home-manager;
    in
      (map
        (path: import path)
        (builtins.attrValues bespoke-home-manager-modules));

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
  ]) ++ (with pkgs.joshua; [ python311 ]);

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

