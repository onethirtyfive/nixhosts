{ pkgs ? import <nixpkgs> {} }:
let
  inherit (pkgs) bundlerEnv ruby_3_1;

  bundlerEnv' = bundlerEnv {
    ruby = ruby_3_1;
    name = "joshua-dev-ruby";
    gemdir = ./.;
  };
in {
  env = bundlerEnv';
  ruby = bundlerEnv'.wrappedRuby;
}
