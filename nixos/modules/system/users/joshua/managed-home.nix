{ homedir, ssh-identities, ... }:
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

  news.display = "show"; # home-manager news

  home.stateVersion = "23.11"; # rarely changed
}

