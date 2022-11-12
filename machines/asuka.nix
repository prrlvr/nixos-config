{ config, pkgs, ... }:

{
  imports = [
    # Machine own config
    ./asuka
    ./asuka/hardware.nix
    ./asuka/home.nix

    # Inherit default config
    ./default/crypt-system.nix
    ./default/locales.nix
    ./default/nix.nix
    ./default/programs.nix
    ./default/users.nix
    ./default/xserver.nix
  ];

  system.stateVersion = "22.05";
}
