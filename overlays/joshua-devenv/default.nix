self: super:
{
  joshua-devenv = {
    python3 = super.callPackage ./python3 {};
    ruby = super.callPackage ./ruby {};
  };
}
