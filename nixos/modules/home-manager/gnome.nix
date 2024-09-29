{ pkgs, homedir, ... }: {
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
    exec = "env XDG_CURRENT_DESKTOP=gnome ${pkgs.gnome.gnome-control-center}/bin/gnome-control-center";
    categories = [ "X-Preferences" ];
    terminal = false;
  };
}
