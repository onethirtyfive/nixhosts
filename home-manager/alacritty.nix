{ inputs, config, ... }:
let
  inherit (inputs) alacritty-theme;
in {
  programs.alacritty = {
    enable = true;

    settings = {
      font.normal.family = "JetBrainsMono Nerd Font";
      font.size = 14; # change to 12 for hyprland after scaling

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
        program = "${config.programs.zsh.package}/bin/zsh";
        args = [ "--login" ];
      };

      window = {
        decorations = "None";
        opacity = 0.97;
        option_as_alt = "Both";
      };
    };
  };
}
