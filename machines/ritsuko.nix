{ config, pkgs, ... }:

{
  imports = [
    # Machine own config
    ./ritsuko
    ./ritsuko/nix.nix
    ./ritsuko/hardware.nix
    ./ritsuko/crypt-system.nix

    # Inherit default config
    ./default/locales.nix
    ./default/programs.nix
    ./default/xserver.nix
  ];

  system.stateVersion = "21.05";
}
