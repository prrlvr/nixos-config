{ pkgs, config, ... }:

{
  networking = {
    hostName = "ayanami";
    useDHCP = false;
    interfaces.wlp4s0.useDHCP = true;
  };

  time.timeZone = "Europe/Paris";

  # services.openssh = {
  #   enable = true;
  #   permitRootLogin = "no";
  # };

  console.keyMap = "us";
}
