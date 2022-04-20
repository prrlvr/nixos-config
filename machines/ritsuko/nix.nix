{ config, lib, pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    trustedUsers = [ "@wheel" ];
    autoOptimiseStore = true;
  };

  # nix cache server
  services.nix-serve = {
    enable = true;
    secretKeyFile = "/var/cache-priv.key.pem";
    port = 8090;
  };

  services.nginx = {
    enable = true;
    virtualHosts = {
      "nix-cache.prrlvr.fr" = {
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
