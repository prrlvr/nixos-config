{ config, pkgs, ... }:

{
  imports = [
    # ./dunst.nix
    ./alacritty.nix
    ./git.nix
    ./gnupg.nix
    ./gtk.nix
    ./i3
    ./kitty.nix
    ./programs.nix
    ./ranger.nix
    ./rofi.nix
    ./ssh.nix
    ./vim.nix
    # ./neovim.nix
    ./xdg.nix
    ./xresources.nix
    ./zsh.nix
    ./programs.nix
  ];

  home.stateVersion = "21.05";

  home.username = "prrlvr";

  home.sessionVariables = {
    EDITOR = "vim";
    TERMINAL = "alacritty";
    MANPAGER = "less --mouse";
    PAGER = "less --mouse";
  };

}
