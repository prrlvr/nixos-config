{ config, lib, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      AddKeysToAgent true
    '';

    matchBlocks = {
      cri-playground = {
        user = "root";
        hostname = "192.168.100.43";
        proxyJump = "root@91.243.117.152";
      };
    };
  };
}
