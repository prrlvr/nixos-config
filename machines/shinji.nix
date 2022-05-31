{ config, pkgs, ... }:

{
  imports = [
    # Machine own config
    ./shinji
    ./shinji/hardware.nix
    ./shinji/home.nix

    # Inherit default config
    ./default/users.nix
    ./default/crypt-system.nix
    ./default/locales.nix
    ./default/nix.nix
    ./default/programs.nix
    ./default/xserver.nix
  ];

  system.stateVersion = "21.05";
}
