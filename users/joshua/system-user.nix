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
      curl
      tree
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBJcYz25rHc1ScfoYjwNaEsIKOLgXz+/VCTJueCTsljE joshua+2023-12@bolide"
    ];
  };
}
