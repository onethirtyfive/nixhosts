{ pkgs, ... }:
let
  inherit (pkgs) lib;
in {
  nix.configureBuildUsers = true;
  nix.package = pkgs.nixVersions.nix_2_22;

  nix.settings = {
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];

    trusted-users = [ "@admin" ];

    netrc-file = "/etc/nix/netrc";

    extra-sandbox-paths = [
      "/etc/nix/netrc"
      "/etc/nix/secrets.toml"
    ];

    experimental-features = [ "nix-command" "flakes" ];

    warn-dirty = false;
    auto-optimise-store = false;
  };

  # Enable experimental nix command and flakes
  nix.extraOptions = lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  nixpkgs.config = {
    allowUnfree = true;
  };

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

  # services.yabai = {
  #   enable = true;
  #
  #   config = {
  #     focus_follows_mouse = "off";
  #     mouse_follows_focus = "off";
  #     window_placement = "second_child";
  #     window_opacity = "on";
  #     window_shadow = "float";
  #     window_topmost = "on";
  #     active_window_opacity = 1.0;
  #     normal_window_opacity = 0.9;
  #     top_padding = 2;
  #     bottom_padding = 2;
  #     left_padding = 2;
  #     right_padding = 2;
  #     window_gap = 2;
  #     layout = "bsp";
  #   };
  # };

  programs.zsh.enable = true;
  programs.nix-index.enable = false;

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Keyboard
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  users.users."joshua".home = "/Users/joshua";
}

