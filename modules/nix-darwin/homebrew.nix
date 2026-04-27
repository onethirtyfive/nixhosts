{
  homebrew = {
    enable = true;
    enableZshIntegration = true;

    caskArgs.appdir = "~/Applications/Homebrew";

    casks = [
      "codex"
      "docker-desktop"
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
