{ ... }:
{
  boot.kernelParams = [
    "video=HDMI-A-1:3840x2160@60"
    "video=HDMI-A-2:3840x2160@60"
  ];

  networking.hostName = "meadowlark";
  networking.hostId = "5e49a298";
}
