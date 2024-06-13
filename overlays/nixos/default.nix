final: prev:
{
  joshua = {
    python3 = prev.callPackage ./python { inherit (prev) python3; };
    ruby31 = prev.callPackage ./ruby {};
  };
}

