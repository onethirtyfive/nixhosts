{ ... }:
{
  imports =
    let
      inherit (builtins) map toPath;
      modules = [
        "tmux" # tmux/default.nix
        "zsh" # zsh/default.nix
        "alacritty.nix"
        "browser.nix"
        "dconf.nix"
        "direnv.nix"
        "git.nix"
        "gnome.nix"
        "mimelist.nix"
        "packages.nix"
        "ssh.nix"
        "starship.nix"
      ];
    in map (module: toPath "${../../../home-manager}/${module}") modules;

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

  news.display = "show"; # home-manager news

  home.stateVersion = "23.11"; # rarely changed
}

