{ ... }:
{
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

  home.stateVersion = "23.11"; # rarely changed
}
