{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;

    settings = {
      font.normal.family = "JetBrainsMono Nerd Font";
      font.size = 16;

      env = {
        TERM = "xterm-256color";
      };

      import = [
        "${pkgs.alacritty-theme}/themes/carbonfox.toml"
      ];

      keyboard = {
        bindings = [
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
          # {
          #   key = "W";
          #   mods = "Command";
          #   chars = "\\x04";
          # }
        ];
      };

      shell = {
        program = "/etc/profiles/per-user/joshua/bin/zsh";
        args = [ "--login" ];
      };

      window = {
        decorations = "Full";
        opacity = 0.97;
        option_as_alt = "Both";
        startup_mode = "Maximized";
      };
    };
  };
}
