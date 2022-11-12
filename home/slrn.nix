{ config, lib, pkgs, ... }:

{
  home.file = {
    ".slrnrc" = {
      executable = false;
      text = ''
        set username "pierre-olivier.rey"
        set hostname "epita.fr"
        set realname "Pierre-Olivier Rey"
        visible_headers "From:,Newsgroups:,Followup-To:,Date:,Subject:"
        set sorting_method 9
        set signature ".signature"
        set save_directory "News"
        set save_posts "posted"
      '';
    };
  };
}
