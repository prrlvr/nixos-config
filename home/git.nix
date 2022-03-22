{ config, lib, pkgs, ... }:

let
  config = {
    core = {
      editor = "vim";
      pager = "less --tabs=4 -RFX";
    };
    init.defaultBranch = "main";
    pull.rebase = true;
    signing.signByDefault = true;
    color.ui = true;
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

    aliases = {
      amend = "commit --amend";
      st = "status";
      lg = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
      lo = "log --graph --decorate --oneline";
    };
  };
}
