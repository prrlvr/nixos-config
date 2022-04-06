{ config, lib, pkgs, ... }:

{
  users.users.lab = {
    initialHashedPassword = "tiger";
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [
      "audio"
      "docker"
      "networkmanager"
      "video"
      "wheel"
    ];
  };
}
