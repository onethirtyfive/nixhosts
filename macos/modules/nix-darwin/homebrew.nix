{
  homebrew = {
    enable = true;

    caskArgs.appdir = "~/Applications/Homebrew";

    casks = [
      "bitwarden"
      "signal"
      "gpg-suite-no-mail"
      "nordvpn"

      "keycastr"

      "istat-menus"
      "fluor"

      "keyboardcleantool"

      "obsidian"
      "karabiner-elements"

      "keybase"
      "microsoft-edge"

      "docker"
    ];
  };
}
