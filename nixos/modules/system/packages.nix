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
    ffmpeg
    inotify-tools
    libnotify
  ];
}
