{ inputs, pkgs, ... }:
let
  inherit (pkgs) lib;

  # At the time of writing this, some python customization was required to get pandas working
  # with mypy. Below is the result--please revisit after some time, this may be redundant:
  tweakPython311 = python311-original: rec {
    python311-withpandasmysupport = python311-original.override {
      packageOverrides = pyself: pysuper: {
        pylsp-mypy = pysuper.pylsp-mypy.overridePythonAttrs (_: {
          doCheck = false;
        });

        tensorboard-data-server = pysuper.tensorboard-data-server.overridePythonAttrs (super: rec {
          version = "0.7.0";
          disabled = pysuper.pythonOlder "3.7";
          src = pysuper.fetchPypi {
            pname = "tensorboard_data_server";
            inherit version;
            inherit (super) format;
            dist = "py3";
            python = "py3";
            hash = "sha256-dT1CFHmbMdp7bZODeVmr67xq+obmnqzx6aMXpI2qMes=";
          };
        });

        tensorboard = pysuper.tensorboard.overridePythonAttrs (super: rec {
          version = "2.13.0";
          disabled = pysuper.pythonOlder "3.7";
          src = pysuper.fetchPypi {
            inherit version;
            inherit (super) pname format;
            dist = "py3";
            python = "py3";
            sha256 = "sha256-q2mWHr3b3cg/X6L/kjNXK9rVuIN3jDXk/pS/F5i9hIE=";
          };
        });
      };
    };

    python311-joshua = (python311-withpandasmysupport.withPackages (ps: with ps; [
      mypy
      pylint

      python-lsp-server
      python-lsp-black
      pylsp-mypy
      pynvim

      pandas
      pandas-stubs

      typing-extensions

      pyserial intelhex
    ]));
  };
in{
  nix.configureBuildUsers = true;
  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  nix.settings = {
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];

    trusted-users = [
      "@admin"
    ];
  };

  # Enable experimental nix command and flakes
  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  nixpkgs.config = {
    allowUnfree = true;
  };

  # pkgs augmentations
  nixpkgs.overlays = [
    (self: super:
      let
        tweaked = tweakPython311 super.python311;
      in
      {
        python311 = tweaked.python311-withpandasmysupport;
        python311-joshua = tweaked.python311-joshua;

        cc2538-bsl = super.cc2538-bsl.override {
          python3Packages = self.python311-joshua.pkgs;
        };
      }
    )
  ];

  environment = {
    shells = with pkgs; [ bash zsh ];
    systemPackages = with pkgs; [
      coreutils
      findutils
      fd
    ];
  };

  # Auto-upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  services.yabai = {
    enable = true;

    config = {
      focus_follows_mouse = "off";
      mouse_follows_focus = "off";
      window_placement = "second_child";
      window_opacity = "on";
      window_shadow = "float";
      window_topmost = "on";
      active_window_opacity = 1.0;
      normal_window_opacity = 0.9;
      top_padding = 2;
      bottom_padding = 2;
      left_padding = 2;
      right_padding = 2;
      window_gap = 2;
      layout = "bsp";
    };
  };

  programs.zsh.enable = true;
  programs.nix-index.enable = true;

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Keyboard
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;


  users.users.joshua.home = "/Users/joshua";
}

