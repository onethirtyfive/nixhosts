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

  # pkgs augmentations
  nixpkgs.overlays = [
    (self: super: {
      python311 = super.python311.override {
        packageOverrides = pyself: pysuper: {
          pylsp-mypy = pysuper.pylsp-mypy.overridePythonAttrs (_: {
            doCheck = false;
          });
        };
      };

      onethirtyfive-dev-python = (self.python311.withPackages (ps: with ps; [
        mypy
        pylint
        python-lsp-server
        python-lsp-black
        pylsp-mypy
      ]));
    })
  ];

  home.stateVersion = "22.11"; # rarely changed
}

