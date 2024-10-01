{ pkgs, ... }:
{
  imports =
    (import ../../../common/modules/system) ++
    [ ./macos-settings.nix ] ++
    (import ../../modules/nix-darwin);

  # Auto-upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

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
}

