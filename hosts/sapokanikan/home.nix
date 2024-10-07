{ pkgs, ... }:
{
  home.file.".config/karabiner" =
    let
      inherit (pkgs) stdenv;

      configStore = stdenv.mkDerivation {
        name = "karabiner-config-store";
        src = ./dotconfig;

        installPhase = ''
          mkdir -p $out
          cp -r $src/karabiner $out/.
        '';
      };
    in
    {
      source = "${configStore}/karabiner";
      target = ".config/karabiner";
    };
}
