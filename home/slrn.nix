{ config, lib, pkgs, ... }:

{
  programs.slrn = {
    enable = true;
  };

  home.file = {
    executable = false;
    text = ''
      set username "pierre-olivier.rey"
      set hostname "epita.fr"
      set realname "Pierre-Olivier Rey"
      visible_headers "From:,Newsgroups:,Followup-To:,Date:,Subject:"
      set sorting_method 9
    '';
  };
}
