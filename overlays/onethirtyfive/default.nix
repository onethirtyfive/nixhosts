self: super:
{
  onethirtyfive = super.onethirtyfive // {
    colorscript = super.callPackage ./colorscript.nix { };
    python3 = self.callPackage ./python3 {};
    ruby = self.callPackage ./ruby {};
  };
}
