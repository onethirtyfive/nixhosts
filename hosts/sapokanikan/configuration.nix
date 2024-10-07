{ ... }:
{
  homebrew = {
    enable = true;

    caskArgs.appdir = "~/Applications/Homebrew";

    casks = [
      "nordvpn"
      "signal"

      "keycastr"

      "obsidian"
      "karabiner-elements"

      "keybase"
    ];
  };

  system.stateVersion = 5;
}
