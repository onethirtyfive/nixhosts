pkgs:
{ ... }:
{
  programs.nushell = {
    enable = true;

    envFile.source = ./envnu;
    configFile.source = ./confignu;
  };
}

