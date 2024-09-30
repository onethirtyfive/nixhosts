{ pkgs, ... }:
let
  inherit (pkgs) stdenv;

  home-manager-imports =
    let
      inherit (builtins) map toPath;
      modulePaths = [
        "zsh" # zsh/default.nix
        "alacritty.nix"
        "direnv.nix"
        "git.nix"
        # "junk-drawer.nix" # exclude self
        "starship.nix"
        "tmux.nix"
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

  programs.fzf.enable = true;
  programs.neovim = {
    enable = true;
    package = pkgs.onethirtyfive.neovim;
  };

  home.stateVersion = "22.11"; # rarely changed
}

