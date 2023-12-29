{ nixpkgs, system, rust-overlay, ... }:
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
in {
  imports =
    let
      paths = builtins.attrValues (import ../../hm);
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
    pkgs.rust-bin.stable.latest.complete
  ]) ++ (with pkgs.joshua; [ cc2538-bsl python311 ]);

  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

  # shells
  programs.starship.enable = true;

  # quality of life
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.direnv.stdlib = ''
    #!/usr/bin/env bash

    declare -A direnv_layout_dirs
    direnv_layout_dir() {
        local hash dir
        echo "''${direnv_layout_dirs[$PWD]:=$(
            hash="$(sha1sum - <<< "$PWD" | head -c40)"
            dir="$(basename "''${PWD}")"
            echo "''${XDG_CACHE_HOME:-''${HOME}/.cache}/direnv/layouts/''${dir}-''${hash}"
        )}"
    }
  '';

  programs.eza.enable = true;
  programs.fzf.enable = true;
  programs.texlive.enable = true; # scapy runtime dep (shellout)

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "23.11"; # rarely changed
}


