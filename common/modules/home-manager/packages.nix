{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # video conversion/playback
    ffmpeg

    # fun
    jp2a
    glow
    vhs
    gum
    slides
    charm

    # languages (relocate?)
    rust-bin.stable.latest.complete
  ] ++ (with pkgs.onethirtyfive; [
    colorscript
    neovim

    # NB. unsure if rb/py versions are needed:
    python3
    ruby
  ]);
}
