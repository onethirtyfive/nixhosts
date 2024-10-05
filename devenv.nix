{ pkgs, ... }:
{
  # https://devenv.sh/reference/options/
  packages = [
    pkgs.devenv # overlaid in flake
    pkgs.cachix
    pkgs.hello
  ];

  enterShell = '''';

  # processes.hello.exec = "hello";

  pre-commit.hooks.nixfmt-rfc-style.enable = true;
  pre-commit.hooks.deadnix.enable = true;
}
