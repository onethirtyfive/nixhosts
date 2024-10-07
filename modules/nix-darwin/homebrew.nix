{
  homebrew = {
    enable = true;

    caskArgs.appdir = "~/Applications/Homebrew";

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
