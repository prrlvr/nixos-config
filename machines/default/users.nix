{ config, lib, pkgs, ... }:

{
  users.users.prrlvr = {
    initialHashedPassword = "test";
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [
      "audio"
      "docker"
      "networkmanager"
      "video"
      "wheel"
      "prrlvr"
    ];

    group = "prrlvr";
  };
}
