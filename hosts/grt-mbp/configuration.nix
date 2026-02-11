{ ... }:
{
  homebrew = {
    enable = true;

    casks = [
      "signal"
      "keycastr"
      "obsidian"
      "ghostty"
    ];
  };

  system.stateVersion = 5;
}
