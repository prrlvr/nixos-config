{ config, lib, pkgs, ... }:

let
  config = {
    core = { editor = "vim"; };
    init.defaultBranch = "main";
    pull.rebase = true;
    color.ui = true;

    signing = {
      signByDefault = true;
      key = "0x4D3849D995551307";
    };

    commit = {
      gpgsing = true;
      verbose = true;
    };
  };
in
{
  programs.git = {
    enable = true;
    userName = "Pierre-Olivier Rey";
    userEmail = "pierre-olivier.rey@epita.fr";
    extraConfig = config;

    delta = {
      enable = true;
      options = {
        syntax-theme = "Solarized (light)";
      };
    };

    aliases = {
      amend = "commit --amend";
      st = "status";
      lg = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
      ci-skip = "push -o ci.skip";
    };
  };
}
