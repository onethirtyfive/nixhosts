pkgs:
{ ... }:
let
  alacritty-theme = pkgs.fetchFromGitHub {
    owner = "alacritty";
    repo = "alacritty-theme";
    rev = "9f769d54eccc0b43bb1ae600575baddea15aae56";
    sha256 = "sha256-MWXo8N19McmbQrN4IrXSp24L3elRNCOz5yDqV//Ycpo=";
  };
in {
  programs.alacritty = {
    enable = true;

    settings = {
      font.normal.family = "JetBrainsMono Nerd Font";
      font.size = 14;

      env = {
        TERM = "xterm-256color";
      };

      import = [
        "${alacritty-theme}/themes/carbonfox.yaml"
      ];

      key_bindings = [
        {
          key = "K";
          mods = "Command|Option";
          action = "ClearHistory";
        }
        {
          key = "Q";
          mods = "Command";
          action = "None";
        }
        {
          key = "W";
          mods = "Command";
          chars = "\\x04";
        }
      ];

      shell = {
        program = "/etc/profiles/per-user/joshua/bin/zsh";
        args = [ "--login" ];
      };

      window = {
        decorations = "Full";
        opacity = 0.97;
        option_as_alt = "Both";
      };
    };
  };
}
