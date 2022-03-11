{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "caps:escape";

    libinput.enable = true;
    desktopManager.xterm.enable = false;
    displayManager.defaultSession = "none+i3";
    windowManager.i3 = {
      package = pkgs.i3-gaps;
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
      ];
    };
    videoDrivers = [ "intel" ];
    deviceSection = ''
      # Option "DRI" "2"
      Option "TearFree" "true"
    '';
  };
}
