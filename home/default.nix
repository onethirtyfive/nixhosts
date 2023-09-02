{ nixpkgs, system, rust-overlay, ... }:
let
  pkgs' = import nixpkgs {
    inherit system;
    overlays = [
      (import ./overlay { rubyPackagePath = ./ruby; })
      rust-overlay.overlays.default
    ];

    config.permittedInsecurePackages = [
      "nodejs-16.20.2"
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
      source = builtins.trace "${configStore}/karabiner" "${configStore}/karabiner";
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
  ]) ++ (with pkgs'.joshua; [ cc2538-bsl python311 ]);

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

