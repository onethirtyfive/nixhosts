{ pkgs, ... }:
let
  inherit (pkgs) stdenv;

  home-manager-imports =
    let
      inherit (builtins) map toPath;
      modulePaths = [
        "tmux" # tmux/default.nix
        "zsh" # zsh/default.nix
        "alacritty.nix"
        "darwin-application-activation.nix"
        "git.nix"
        # "junk-drawer.nix" # exclude self
        "starship.nix"
      ];
    in map (module: ./${module}) modulePaths;
in {
  imports = home-manager-imports;

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

  home.packages = (builtins.attrValues {
    inherit (pkgs) curl fd lazydocker less ripgrep coreutils gnused;
  })
    ++ [ pkgs.onethirtyfive.python3 pkgs.onethirtyfive.ruby ];

  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
  };

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

  programs.fzf.enable = true;
  programs.neovim = {
    enable = true;
    package = pkgs.onethirtyfive.neovim;
  };

  home.stateVersion = "22.11"; # rarely changed
}

