{ inputs, overlays, ... }:
let
  inherit (inputs) rust-overlay onethirtyfive-neovim;
in {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];
  nixpkgs.overlays = [
    rust-overlay.overlays.default
    onethirtyfive-neovim.overlays.default
    overlays.onethirtyfive
  ];
}
