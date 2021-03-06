{ config, pkgs, ... }:

{
  gtk = {
    enable = true;
    font = {
      package = pkgs.cantarell-fonts;
      name = "Cantarell";
      size = 11;
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    theme = {
      package = pkgs.arc-theme;
      name = "Arc-Dark";
    };
    gtk2 = {
      extraConfig = ''
        gtk-cursor-theme-name="Adwaita"
        gtk-cursor-theme-size=05
        gtk-toolbar-style=GTK_TOOLBAR_BOTH_HORIZ
        gtk-toolbar-icon-size=GTK_ICON_SIZE_TOOLBAR
        gtk-button-images=0
        gtk-menu-images=0
      '';
    };
    gtk3 = {
      extraConfig = {
        gtk-cursor-theme-name = "Adwaita";
        gtk-cursor-theme-size = 05;
      };
      bookmarks = [
        "file://${config.home.homeDirectory}/Downloads"
        "file://${config.home.homeDirectory}/epita"
        "file://${config.home.homeDirectory}/tiger"
        "file://${config.home.homeDirectory}/epita/assistants/piscine"
      ];
    };
  };

}
