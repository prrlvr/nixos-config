{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    python39
    arandr
    dconf
    dbus
    feh
    firefox
    git
    tree
    ranger
    networkmanagerapplet
    vim
    wget
    pavucontrol
    gcc
    gcc.man
    clang_12
    tmux
  ];

  programs = {
    gnupg.agent.enable = true;
    ssh.startAgent = true;
    light.enable = true;
    nm-applet.enable = true;
  };
  services.openssh.enable = true;

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
    };
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Mononoki" "FiraCode" "Iosevka" ]; })
  ];

  networking.networkmanager.enable = true;
  networking.firewall = {
    # if packets are still dropped, they will show up in dmesg
    logReversePathDrops = true;
    # wireguard trips rpfilter up
    extraCommands = ''
      ip46tables -t raw -I nixos-fw-rpfilter -p udp -m udp --sport 49312 -j RETURN
      ip46tables -t raw -I nixos-fw-rpfilter -p udp -m udp --dport 49312  -j RETURN
    '';
    extraStopCommands = ''
      ip46tables -t raw -D nixos-fw-rpfilter -p udp -m udp --sport 49312 -j RETURN || true
      ip46tables -t raw -D nixos-fw-rpfilter -p udp -m udp --dport 49312 -j RETURN || true
    '';
  };
}
