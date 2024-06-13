{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" ]; })
    fira
    font-awesome
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts
    liberation_ttf
  ];
}

