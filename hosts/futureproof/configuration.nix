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
      "keybase"
    ];
  };

  system.stateVersion = 5;
}
