{ pkgs, ... }:
{
  # TODO: Set up homebrew.
  users.users.joshua = {
    home = "/Users/joshua";

    packages = with pkgs; [
      slides

      # languages (relocate?)
      rust-bin.stable.latest.complete
    ];

    openssh.authorizedKeys.keys = [
    ];
  };
}
