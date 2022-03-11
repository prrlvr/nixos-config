{ config, lib, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      scrolling = { history = 10000;
        multiplier = 3;
      };

      font = {
        normal = {
          family = "Iosevka Nerd Font";
          style = "Regular";
        };
        size = 11;
        scale_with_dpi = true;
      };

      # background_opacity = 1.0;
      bell.duration = 0;
      selection.save_to_clipboard = true;
      cursor.style = "Underline";
      shell.program = "${pkgs.zsh}/bin/zsh";
      window = {
        decorations = "none";
        padding = {
          x = 8;
          y = 8;
        };
      };
# Colors (Solarized Light)
      colors = {
        primary = {
          background= "0xfdf6e3";
          foreground= "0x586e75";
        };

        normal =  {
          black =   "0x073642";
          red =     "0xdc322f";
          green =   "0x859900";
          yellow =  "0xb58900";
          blue =    "0x268bd2";
          magenta = "0xd33682";
          cyan =    "0x2aa198";
          white =   "0xeee8d5";
        };

        bright = {
          black =   "0x002b36";
          red =     "0xcb4b16";
          green =   "0x586e75";
          yellow =  "0x657b83";
          blue =    "0x839496";
          magenta = "0x6c71c4";
          cyan =    "0x93a1a1";
          white =   "0xfdf6e3";
        };
       cursor = {
          text = "0x002635";
          cursor = "0x268bd2";
        };
      };
    };
  };
}
