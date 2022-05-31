{ config, pkgs, ... }:

{
  home-manager.users.prrlvr = {
    # my.polybar = {
    #   enable = true;
    #   wlan = "wlp2s0";
    #   backlight = true;
    #   batteries = [
    #     {
    #       battery = "BAT0";
    #       adpater = "AC0";
    #       full-at = "100";
    #     }
    #   ];
    # };
    home.packages = with pkgs; [
      gnumake
      gcc
      maven
      jetbrains.idea-community
    ];
  };
}
