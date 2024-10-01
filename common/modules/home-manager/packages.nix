{ pkgs, ... }:
{
  home.packages = with pkgs; with nodePackages_latest; [
    bitwarden
    microsoft-edge
    signal-desktop

    # video conversion/playback
    ffmpeg
    vlc

    # fun
    slides

    # languages (relocate?)
    rust-bin.stable.latest.complete
  ] ++ (with pkgs.onethirtyfive; [
    colorscript

    # NB. unsure if rb/py versions are needed:
    python3
    ruby

    # NB. neovim installed by `programs.neovim.package`
  ]);
}
