{ pkgs, ... }:
let
  inherit (pkgs) stdenv;
in {
  home.file.".config/karabiner" =
    let
      configStore = stdenv.mkDerivation {
        name = "karabiner-config-store";
        src = ./dotconfig;

        installPhase = ''
          mkdir -p $out
          cp -r $src/karabiner $out/.
        '';
      };
    in {
      source = "${configStore}/karabiner";
      target = ".config/karabiner";
    };

  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
  };

  home.stateVersion = "22.11"; # rarely changed
}
