{ pkgs, ... }:

{
  networking = {
    hostName = "ayanami";
    useDHCP = false;
    interfaces.wlp4s0.useDHCP = true;
  };

  time.timeZone = "Europe/Paris";

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # services.openssh = {
  #   enable = true;
  #   permitRootLogin = "no";
  # };

  console.keyMap = "us";
}
