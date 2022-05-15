{ config, lib, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      AddKeysToAgent true
    '';

    matchBlocks = {
      nix-cache = {
        user = "root";
        hostname = "192.168.1.47";
        identitiesOnly = true;
        identityFile = "/home/prrlvr/.ssh/id_rsa";
      };
    };
  };
}
