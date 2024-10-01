{ pkgs, ... }:
{
  users.users.joshua = {
    isNormalUser = true;

    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "video"
      "docker"
    ];

    initialPassword = "hellothere";

    packages = with pkgs; [
      # consumer
      discord
      easyeffects
      gimp
      figma-linux
      libreoffice
      (mpv.override { scripts = [mpvScripts.mpris]; })
      obsidian
      signal-desktop

      # fun
      jp2a
      glow
      vhs
      gum
      slides
      charm
    ];

    openssh.authorizedKeys.keys = [
    ];
  };
}
