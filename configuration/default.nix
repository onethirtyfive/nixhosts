{ config, inputs, pkgs, ... }:
let
  inherit (pkgs) lib;
in
{
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

  environment = {
    shells = with pkgs; [ bash zsh ];
    systemPackages = [ pkgs.coreutils ];
  };

  # Auto-upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  services.yabai = {
    enable = true;

    config = {
      focus_follows_mouse = "autoraise";
      mouse_follows_focus = "off";
      window_placement    = "second_child";
      window_opacity      = "off";
      top_padding         = 6;
      bottom_padding      = 6;
      left_padding        = 6;
      right_padding       = 6;
      window_gap          = 6;
      layout              = "bsp";
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
}

