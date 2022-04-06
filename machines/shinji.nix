{ config, pkgs, ... }:

{
  imports = [
    # Machine own config
    ./shinji
    ./shinji/users.nix
    ./shinji/hardware.nix
    ./shinji/home.nix

    # Inherit default config
    ./default/crypt-system.nix
    ./default/locales.nix
    ./default/nix.nix
    ./default/programs.nix
    ./default/xserver.nix
  ];

  system.stateVersion = "21.05";
}
