{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bitwarden
    discord
    easyeffects
    gimp
    google-chrome
    microsoft-edge
    obsidian
    signal-desktop
    vlc
  ];
}
