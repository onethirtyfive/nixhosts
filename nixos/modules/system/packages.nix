{ pkgs, ... }:
{
  # available universally on machine
  environment.systemPackages = with pkgs; [
    # processes and machine
    acpi
    killall
    htop

    # network tools
    curl
    socat
    wget

    # daily drivers
    bat
    coreutils
    fd
    fzf
    git
    git-lfs
    gnused
    jq
    lazydocker
    less
    pinentry
    ripgrep
    tree
    unzip
    zip

    # misc
    inotify-tools
    libnotify

    # video conversion/playback
    ffmpeg
    vlc

    # AirPlay mirroring
    # gst_all_1.gst-libav
    # gst_all_1.gst-plugins-rs
    # gst_all_1.gst-plugins-base
    # gst_all_1.gst-plugins-good
    # gst_all_1.gst-plugins-ugly
    # streamlink
    # uxplay # AirPlay mirroring server
  ];
}
