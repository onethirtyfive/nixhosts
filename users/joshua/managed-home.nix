{ config, system, pkgs, lib, homedir, ssh-identities, ... }:
{
  imports =
    let
      bespoke-home-manager-modules = import ../../home-manager;
    in (with bespoke-home-manager-modules; [
      # universal
      alacritty
      direnv
      git
      starship
      tmux
      zsh

      # possibly universal
      browser

      # linux-only
      dconf
      mimelist
      packages
    ]);

  home.sessionVariables = {
    QT_XCB_GL_INTEGRATION = "none"; # kde-connect
    NIXPKGS_ALLOW_UNFREE = "1";
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
    BAT_THEME = "base16";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  services = {
    kdeconnect = {
      enable = true;
      indicator = true;
    };
  };

  programs.ssh = {
    enable = true;

    matchBlocks =
    let
      identityFile = map (i: "${homedir}/.ssh/${i}") ssh-identities;
    in {
      github = {
        user = "git";
        host = "github.com";
        inherit identityFile;
      };
      gitlab = {
        user = "git";
        host = "gitlab.com";
        inherit identityFile;
      };
      bitbucket = {
        user = "git";
        host = "bitbucket.org";
        inherit identityFile;
      };
    };

    extraConfig = ''
      AddKeysToAgent yes
    '';
  };

  xdg.desktopEntries."org.gnome.Settings" = {
    name = "Settings";
    comment = "Gnome Control Center";
    icon = "org.gnome.Settings";
    exec = "env XDG_CURRENT_DESKTOP=gnome ${pkgs.gnome.gnome-control-center}/bin/gnome-control-center";
    categories = [ "X-Preferences" ];
    terminal = false;
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

  news.display = "show"; # home-manager news

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "23.11"; # rarely changed
}

