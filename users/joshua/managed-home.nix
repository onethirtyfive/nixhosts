{ pkgs, homedir, ... }:
{
  imports =
    let
      bespoke-home-manager-modules = import ../../modules/home-manager;
    in with bespoke-home-manager-modules; [
      # universal
      alacritty
      direnv
      git
      neovim
      starship
      tmux
      zsh

      # possibly universal
      browser

      # linux-only
      dconf
      hyprland
      mimelist
      packages
    ];

  home.sessionVariables = {
    QT_XCB_GL_INTEGRATION = "none"; # kde-connect
    NIXPKGS_ALLOW_UNFREE = "1";
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
    BAT_THEME = "base16";
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

  gtk.gtk3.bookmarks = [
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

  news.display = "show"; # home-manager news

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "23.11"; # rarely changed
}

