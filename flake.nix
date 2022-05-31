{
  description = "prrlvr nix config";

  inputs = {
    nixos-hardware = {
      type = "github";
      owner = "NixOS";
      repo = "nixos-hardware";
      ref = "master";
    };

    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };

    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils = {
      type = "github";
      owner = "numtide";
      repo = "flake-utils";
      ref = "master";
    };

    nix-doom-emacs = {
      url = "github:vlaci/nix-doom-emacs?ref=develop";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.emacs-overlay.follows = "emacs-overlay";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      flake = false;
    };

    pre-commit-hooks = {
      type = "github";
      owner = "cachix";
      repo = "pre-commit-hooks.nix";
      ref = "master";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs =
    { self
    , flake-utils
    , nixpkgs
    , home-manager
    , nix-doom-emacs
    , pre-commit-hooks
    , ...
    }@inputs:
    flake-utils.lib.eachDefaultSystem
      (system:
      let
        inherit (inputs.flake-utils.lib) flattenTree;
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        checks = {
          pre-commit = pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks.nixpkgs-fmt.enable = true;
          };
        };

        devShell = pkgs.mkShell {
          name = "NixOS-config-devShell";
          nativeBuildInputs = with pkgs; [
            nix-prefetch-github
            nixpkgs-fmt
          ];
        };

        # packages = flattenTree
        #   (import ./pkgs {
        #     pkgs = import nixpkgs { inherit system; };
        #   });
        packages = pkgs;
      }
      )
    //
    {
      nixosModules = {
        home = {
          home-manager = {
            useUserPackages = true;
            useGlobalPkgs = true;
            verbose = true;
            users = {
              prrlvr = import ./home;
              # {
              # imports = [ nix-doom-emacs.hmModule ./home ];
              # programs.doom-emacs = {
              #   enable = true;
              #   doomPrivateDir = ./.doom.d;
              #   emacsPackagesOverlay = self: super: {
              #     # fixes https://github.com/vlaci/nix-doom-emacs/issues/394
              #     gitignore-mode = nixpkgs.emacsPackages.git-modes;
              #     gitconfig-mode = nixpkgs.emacsPackages.git-modes;
              #   };
              # };
            };
          };
        };
      };

      nixosConfigurations =
        let
          system = "x86_64-linux";
          # custom_overlays = [
          #   (self: super: {
          #     own = import ./pkgs { pkgs = super; };
          #   })
          # ];
          custom_modules = [
            home-manager.nixosModule
            # { nixpkgs.overlays = custom_overlays; }
          ] ++ (nixpkgs.lib.attrValues self.nixosModules);
        in
        {
          ayanami = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              {
                imports = [
                  ./machines/ayanami.nix

                  inputs.nixos-hardware.nixosModules.common-cpu-intel
                  inputs.nixos-hardware.nixosModules.common-pc-laptop
                ] ++ custom_modules;
              }
            ];
          };

          shinji = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              {
                imports = [
                  ./machines/shinji.nix

                  inputs.nixos-hardware.nixosModules.common-cpu-intel
                ] ++ custom_modules;
              }
            ];
          };

          ritsuko = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              {
                imports = [
                  ./machines/ritsuko.nix
                ];
              }
            ];
          };
        };
    };
}
