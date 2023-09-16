pkgs:
{ ... }:
let
  alacritty-theme = pkgs.fetchFromGitHub {
    owner = "alacritty";
    repo = "alacritty-theme";
    rev = "981f48c9e4de2c0b657ed23a8ca425d8bf6ae0c7";
    sha256 = "sha256-ABZFJx+TbGtAr84WVTgB2Oa6MAHhQFoORInVjbw3UGk=";
  };
in {
  programs.alacritty = {
    enable = true;

    settings = {
      font.normal.family = "JetBrainsMono Nerd Font";
      font.size = 14;

      import = [
        "${alacritty-theme}/themes/solarized_dark.yaml"
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
        decorations = "buttonless";
        opacity = 0.97;
        option_as_alt = "Both";
      };
    };
  };
}
