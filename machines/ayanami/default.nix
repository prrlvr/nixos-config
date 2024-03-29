{ pkgs, config, ... }:

{
  networking = {
    hostName = "ayanami";
    useDHCP = false;
    interfaces.wlp4s0.useDHCP = true;
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
  };

  time.timeZone = "Europe/Paris";

  # services.openssh = {
  #   enable = true;
  #   permitRootLogin = "no";
  # };

  console.keyMap = "us";

  services.udev.packages = [ pkgs.yubikey-personalization ];

  services.pcscd.enable = true;

  environment.shellInit = ''
    export GPG_TTY="$(tty)"
    gpg-connect-agent /bye
    export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
  '';
}
