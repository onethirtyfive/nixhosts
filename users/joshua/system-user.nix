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

      # languages (relocate?)
      rust-bin.stable.latest.complete
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBJcYz25rHc1ScfoYjwNaEsIKOLgXz+/VCTJueCTsljE joshua+2023-12@bolide"
    ];
  };
}
