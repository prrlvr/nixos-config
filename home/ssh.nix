{ config, lib, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      AddKeysToAgent true
    '';

    matchBlocks = {
      shinji-0 = {
        user = "root";
        hostname = "10.29.105.41";
      };

      shinji-1 = {
        user = "root";
        hostname = "10.29.114.183";
      };

      shinji-2 = {
        user = "root";
        hostname = "10.29.118.213";
      };

      shinji-3 = {
        user = "root";
        hostname = "10.29.104.245";
      };
    };

  };
}
