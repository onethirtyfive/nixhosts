{ rubyPackagePath }:
final: prev:
{
  joshua = {
    ruby31 = prev.callPackage rubyPackagePath {};
  };
}
