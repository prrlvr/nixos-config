{ pkgs, config, ... }:

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

  # nix cache server
  services.nix-serve = {
    enable = true;
    secretKeyFile = "/var/cache-priv.key.pem";
  };

  services.nginx = {
    enable = true;
    virtualHosts = {
      "10.29.125.103" = {
        serverAliases = [ "binarycache" ];
        locations."/".extraConfig = ''
          proxy_pass http://localhost:${toString config.services.nix-serve.port};
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        '';
      };
    };
  };

}
