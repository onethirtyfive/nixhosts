{ bundlerEnv, ruby }:
let
  joshua-dev-ruby = bundlerEnv {
    ruby = ruby;
    name = "joshua-dev-ruby";
    gemdir = ./.;
  };
in {
  env = joshua-dev-ruby;
  ruby = joshua-dev-ruby.wrappedRuby;
}
