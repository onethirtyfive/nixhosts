{ system, inputs, ... }:
let
  inherit (inputs) nixpkgs-darwin onethirtyfive-neovim rust-overlay;

  pkgs' = import nixpkgs-darwin {
    inherit system;
    overlays = [
      (import ./overlay { rubyPackagePath = ./ruby; })
      rust-overlay.overlays.default
    ];

    config.permittedInsecurePackages = [
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
        ./tmux
        ./zsh
      ];
    in map withCustomPkgs paths;

  home.file.".config/karabiner" =
    let
      configStore = stdenv.mkDerivation {
        name = "karabiner-config-store";
        src = ./dotconfig;

        installPhase = ''
          mkdir -p $out
          cp -r $src/karabiner $out/.
        '';
      };
    in {
      source = "${configStore}/karabiner";
      target = ".config/karabiner";
    };

  home.packages = (with pkgs'; [
    curl
    fd
    lazydocker
    less
    ripgrep
    coreutils
    gnused

    pkgs.rust-bin.stable.latest.complete
  ]) ++ (with pkgs'.joshua; [ ]);

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
  programs.neovim = {
    enable = true;
    package = onethirtyfive-neovim.packages.${system}.default;
  };

  home.stateVersion = "22.11"; # rarely changed
}

