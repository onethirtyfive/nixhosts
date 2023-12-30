{ bundlerEnv, ruby_3_1 }:
let
  joshua-dev-ruby = bundlerEnv {
    ruby = ruby_3_1;
    name = "joshua-dev-ruby";
    gemdir = ./.;
  };
in {
  env = joshua-dev-ruby;
  ruby = joshua-dev-ruby.wrappedRuby;
}
