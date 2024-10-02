{ config, pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome = {
    enable = true;
    extraGSettingsOverridePackages = [
      pkgs.nautilus-open-any-terminal
    ];
  };

  # For Gnome extensions, apparently, via NixOS GNOME wiki
  services.udev.packages = [
    pkgs.gnome-settings-daemon
  ];

  environment = {
    sessionVariables = {
      NAUTILUS_EXTENSION_DIR = "${config.system.path}/lib/nautilus/extensions-4";
    };

    pathsToLink = [
      "/share/nautilus-python/extensions"
    ];

    systemPackages = (with pkgs; [
      gedit
      gnome-extension-manager
      nautilus-open-any-terminal
      qogir-icon-theme
      d-spy
      icon-library
      nautilus-python
      dconf-editor
      gnomeExtensions.astra-monitor
      gnomeExtensions.caffeine
      gnomeExtensions.pano
    ]);

    gnome.excludePackages = (with pkgs; [
      # gnome-text-editor
      gnome-photos
      gnome-tour
      gnome-connections
      # snapshot
      cheese # webcam tool
      gnome-music
      epiphany # web browser
      geary # email reader
      evince # document viewer
      gnome-characters
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
      yelp # Help view
      gnome-contacts
      gnome-initial-setup
      gnome-shell-extensions
      gnome-maps
      gnome-font-viewer
    ]);
  };
}
