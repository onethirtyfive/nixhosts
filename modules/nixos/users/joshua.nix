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
    ];

    openssh.authorizedKeys.keys = [
    ];
  };
}
