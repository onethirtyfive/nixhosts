{ pkgs, ... }:
{
  xdg.desktopEntries = {
    "lf" = {
      name = "lf";
      noDisplay = true;
    };
  };

  home.packages = with pkgs; with nodePackages_latest; with gnome; [
    # colorscript
    (import ./colorscript.nix { inherit pkgs; })

    # gui
    obsidian
    (mpv.override { scripts = [mpvScripts.mpris]; })
    libreoffice
    d-spy
    easyeffects
    gimp
    transmission_4-gtk
    discord
    icon-library
    dconf-editor
    figma-linux

    # tools
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

    # hyprland
    wl-gammactl
    wl-clipboard
    wf-recorder
    hyprpicker
    wayshot
    swappy
    slurp
    imagemagick
    pavucontrol
    brightnessctl
    swww

    # fun
    fortune
    jp2a
    pywal
    glow
    vhs
    gum
    slides
    charm
    skate
    wine-staging

    # languages
    rust-bin.stable.latest.complete
  ] ++ (with pkgs.joshua; [ python311 ]);
}

