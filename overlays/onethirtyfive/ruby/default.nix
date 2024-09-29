{ bundlerEnv, ruby, ... }:
(bundlerEnv {
  inherit ruby;
  name = "joshua-devenv-ruby";
  gemdir = ./.;
}).wrappedRuby
