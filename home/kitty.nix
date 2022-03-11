{ pkgs, lib, ... }:

let

in
{
  programs.kitty = {
    enable = false;

    font = {
      package = null;
      name = "Iosevka";
      size = 12;
    };

    settings = {

    };
  };

}
