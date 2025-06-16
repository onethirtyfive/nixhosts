{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "AtkynsonMono"
        "CascadiaCode"
        "JetBrainsMono"
      ];
    })
    fira
    font-awesome
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts
    liberation_ttf
  ];
}
