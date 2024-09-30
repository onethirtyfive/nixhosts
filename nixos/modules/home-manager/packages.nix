{ pkgs, ... }:
{
  home.packages = with pkgs; with nodePackages_latest; [
    # colorscript
    (import ./colorscript.nix { inherit pkgs; })

  ] ++ (with pkgs.onethirtyfive; [ neovim python3 ruby ]);
}

