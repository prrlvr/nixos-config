{ config, lib, pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    trustedUsers = [ "@wheel" ];
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      #   dates = "weekly";
      #   options = "--delete-older-than 7d";
    };
  };

  nix = {
    binaryCaches = [
      "https://s3.cri.epita.fr/cri-nix-cache.s3.cri.epita.fr"
      "https://nix-community.cachix.org"
      "https://cache.nixos.org/"
    ];
    requireSignedBinaryCaches = false;
  };
}
