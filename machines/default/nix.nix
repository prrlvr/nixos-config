{ config, lib, pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    trustedUsers = [ "@wheel" "@prrlvr" ];
    autoOptimiseStore = true;
    # gc = {
    #   automatic = true;
    #   dates = "weekly";
    #   options = "--delete-older-than 7d";
    # };
  };

  nix = {
    binaryCaches = [
      # "https://nix-cache.prrlvr.fr"
      "https://s3.cri.epita.fr/cri-nix-cache.s3.cri.epita.fr"
      "https://nix-community.cachix.org"
      "https://cache.nixos.org/"
      "https://cache.iog.io"
      # "http://192.168.0.207"
    ];
    binaryCachePublicKeys = [
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
    ];
    requireSignedBinaryCaches = false;
  };
}
