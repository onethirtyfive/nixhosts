{ lib, ... }:
{
  boot.kernelParams = [
    # "video=HDMI-A-1:3840x2160@60"
    # "video=HDMI-A-2:3840x2160@60"
  ];

  networking.hostName = "ozymandian";
  networking.hostId = "8425e349";

  # Use TLP+auto-cpufreq instead of GNOME's simpler power-profiles-daemon.
  services.power-profiles-daemon.enable = lib.mkForce false;
  services.auto-cpufreq.enable = true;
  services.tlp.enable = true;
}
