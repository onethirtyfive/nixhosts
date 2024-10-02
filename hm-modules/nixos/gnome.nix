{ pkgs, homedir, ... }:
let
  browser = "google-chrome.desktop";
  file-manager = "org.gnome.Nautilus.desktop";
  image-viewer = "org.gnome.Loupe.desktop";
  torrent = "transmission-gtk.desktop";
in {
  xdg.mimeApps = rec {
    enable = true;
    associations.added = defaultApplications;
    defaultApplications = {
      "inode/directory" = file-manager;

      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "application/xhtml+xml" = browser;
      "text/html" = browser;

      "x-scheme-handler/magnet" = torrent;
      "application/pdf" = browser;

      "image/jpeg" = image-viewer;
      "image/bmp" = image-viewer;
      "image/gif" = image-viewer;
      "image/jpg" = image-viewer;
      "image/pjpeg" = image-viewer;
      "image/png" = image-viewer;
      "image/tiff" = image-viewer;
      "image/webp" = image-viewer;
      "image/x-bmp" = image-viewer;
      "image/x-gray" = image-viewer;
      "image/x-icb" = image-viewer;
      "image/x-ico" = image-viewer;
      "image/x-png" = image-viewer;
      "image/x-portable-anymap" = image-viewer;
      "image/x-portable-bitmap" = image-viewer;
      "image/x-portable-graymap" = image-viewer;
      "image/x-portable-pixmap" = image-viewer;
      "image/x-xbitmap" = image-viewer;
      "image/x-xpixmap" = image-viewer;
      "image/x-pcx" = image-viewer;
      "image/svg+xml" = image-viewer;
      "image/svg+xml-compressed" = image-viewer;
      "image/vnd.wap.wbmp" = image-viewer;
      "image/x-icns" = image-viewer;
    };
  };

  gtk = {
    enable = true;
    gtk3.bookmarks = [
      "file://${homedir}/Documents"
      "file://${homedir}/Music"
      "file://${homedir}/Pictures"
      "file://${homedir}/Videos"
      "file://${homedir}/Downloads"
      "file://${homedir}/Desktop"
      "file://${homedir}/Projects"
      "file://${homedir}/Vault"
      "file://${homedir}/Vault/School"
      "file://${homedir}/.config Config"
      "file://${homedir}/.local/share Local"
    ];
  };

  xdg.desktopEntries."org.gnome.Settings" = {
    name = "Settings";
    comment = "Gnome Control Center";
    icon = "org.gnome.Settings";
    exec = "env XDG_CURRENT_DESKTOP=gnome ${pkgs.gnome-control-center}/bin/gnome-control-center";
    categories = [ "X-Preferences" ];
    terminal = false;
  };
}
