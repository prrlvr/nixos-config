{ config, pkgs, ... }:

{
  imports = [
    # Machine own config
    ./asuka
    ./asuka/hardware.nix
    ./asuka/home.nix
    ./asuka/xserver.nix

    # Inherit default config
    ./default/crypt-system.nix
    ./default/locales.nix
    ./default/nix.nix
    ./default/programs.nix
    ./default/users.nix
  ];

  system.stateVersion = "22.05";
}
