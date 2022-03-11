{ config, pkgs, ... }:

{
  imports = [
    # Machine own config
    ./ayanami
    ./ayanami/hardware.nix
    ./ayanami/home.nix

    # Inherit default config
    ./default/crypt-system.nix
    ./default/locales.nix
    ./default/nix.nix
    ./default/programs.nix
    ./default/users.nix
    ./default/xserver.nix
  ];

  system.stateVersion = "21.05";
}
