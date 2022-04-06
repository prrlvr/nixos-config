{ pkgs, ... }:

{
  networking = {
    hostName = "shinji";
    useDHCP = false;
    # interfaces.wlp4s0.useDHCP = true;
  };

  time.timeZone = "Europe/Paris";

  sound.enable = false;
  hardware.pulseaudio.enable = false;

  services.openssh = {
    enable = true;
    permitRootLogin = "no";
  };

  console.keyMap = "us";
}
