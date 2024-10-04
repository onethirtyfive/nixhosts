{ lib, ... }:
with lib.hm.gvariant;
{
  dconf.settings = {
    "org/gnome/desktop/peripherals/keyboard" = {
      repeat-interval = lib.gvariant.mkUint32 14;
      delay = lib.gvariant.mkUint32 350;
    };

    "org/gnome/desktop/input-sources" = {
      sources = [
        (mkTuple [
          "xkb"
          "en"
        ])
      ];
      xkb-options = [ "terminate:ctrl_alt_bksp,caps:escape" ];
    };

    "org/gnome/desktop/interface" = {
      show-battery-percentage = true;
      enable-hot-corners = false;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      natural-scroll = false;
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/search-providers" = {
      disabled = [ "org.gnome.Boxes.desktop" ];
      enabled = [ "org.gnome.Weather.desktop" ];
      sort-order = [
        "org.gnome.Contacts.desktop"
        "org.gnome.Documents.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Calendar.desktop"
        "org.gnome.Calculator.desktop"
        "org.gnome.Software.desktop"
        "org.gnome.Settings.desktop"
        "org.gnome.clocks.desktop"
        "org.gnome.design.IconLibrary.desktop"
        "org.gnome.seahorse.Application.desktop"
        "org.gnome.Weather.desktop"
        "org.gnome.Boxes.desktop"
      ];
    };

    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 0;
    };

    "org/gnome/shell/window-switcher" = {
      current-workspace-only = false;
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Alt>q" ];
      move-to-workspace-1 = [ "<Shift><Super>1" ];
      move-to-workspace-2 = [ "<Shift><Super>2" ];
      move-to-workspace-3 = [ "<Shift><Super>3" ];
      move-to-workspace-4 = [ "<Shift><Super>4" ];
      move-to-workspace-5 = [ "<Shift><Super>5" ];
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      switch-to-workspace-5 = [ "<Super>5" ];
      toggle-fullscreen = [ "<Super>g" ];
      switch-applications = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
      switch-applications-backward = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
      switch-windows = [
        "<Alt>Tab"
        "<Super>Tab"
      ];
      switch-windows-backward = [
        "<Shift><Alt>Tab"
        "<Shift><Super>Tab"
      ];
      minimize = [
        "<Super><Shift>M"
      ];
    };

    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [ ];
      switch-to-application-2 = [ ];
      switch-to-application-3 = [ ];
      switch-to-application-4 = [ ];
      switch-to-application-5 = [ ];
    };

    "org/gnome/desktop/wm/preferences" = {
      mouse-button-modifier = "<Super>";
      num-workspaces = 5;
      resize-with-right-button = true;
      focus-mode = "click";
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = false;
      edge-tiling = true;
      num-workspaces = 5;
      workspaces-only-on-primary = true;
      experimental-features = [
        "scale-monitor-framebuffer"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
      mic-mute = [ "AudioMicMute" ];
      next = [ "AudioNext" ];
      play = [ "AudioPlay" ];
      previous = [ "AudioPrev" ];
      stop = [ "AudioStop" ];
      volume-down = [ "AudioLowerVolume" ];
      volume-up = [ "AudioRaiseVolume" ];

      home = [ "<Super>e" ];
      www = [ "<Super>w" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "xterm";
      name = "term";
    };

    "org/gnome/settings-daemon/plugins/power" = {
      idle-dim = false;
      power-button-action = "interactive";
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-battery-type = "nothing";
    };

    "org/gnome/shell" = {
      favorite-apps = [
        "Alacritty.desktop"
        "firefox.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Calendar.desktop"
        "obsidian.desktop"
        "transmission-gtk.desktop"
        "discord.desktop"
        "org.gnome.Software.desktop"
      ];
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = false;
    };

    "org/gnome/shell/keybindings" = {
      toggle-application-view = [ "<Super>r" ];
    };

    "system/locale" = {
      region = "en_US.UTF-8";
    };

    "com/github/stunkymonkey/nautilus-open-any-terminal" = {
      terminal = "alacritty";
    };

    # "org/virt-manager/virt-manager/connections" = {
    #   autoconnect = ["qemu:///system"];
    #     uris = ["qemu:///system"];
    # };
  };
}
