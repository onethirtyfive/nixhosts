{ pkgs, ... }:
{
  # We may want a different set--or to source differently--macos apps.
  environment.systemPackages = with pkgs; [
    # consumer
    discord
    easyeffects
    gimp
    figma-linux
    libreoffice
    (mpv.override { scripts = [mpvScripts.mpris]; })
    obsidian
    signal-desktop

    # fun
    jp2a
    glow
    vhs
    gum
    slides
    charm

    # languages (relocate?)
    rust-bin.stable.latest.complete
  ];
}

