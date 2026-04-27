{
  homebrew = {
    enable = true;

    caskArgs.appdir = "~/Applications/Homebrew";

    brews = [
      "codex"
    ];

    casks = [
      "docker"
      "bitwarden"
      "gpg-suite-no-mail"

      "fluor"
      "istat-menus"
      "keycastr"
      "keyboardcleantool"

      "microsoft-edge"
    ];
  };
}
