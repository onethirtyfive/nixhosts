{ pkgs, ... }:
{
  home.packages = with pkgs; with nodePackages_latest; [
    # colorscript
    (import ./colorscript.nix { inherit pkgs; })

    # uncontroversial cross-platform tools
    bat
    eza
    fd
    ripgrep
    fzf
    socat
    jq
    acpi
    inotify-tools
    ffmpeg
    libnotify
    killall
    zip
    unzip
    glib
    curl
    lazydocker
    less
    gnused
    coreutils
    pinentry
    git-lfs
  ] ++ (with pkgs.joshua-devenv; [ python3 ruby ]);
}

