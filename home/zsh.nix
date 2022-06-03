{ config, lib, pkgs, ... }:

let
  nix-zsh-completions = {
    name = "nix-zsh-completions";
    src = pkgs.fetchFromGitHub {
      owner = "spwhitt";
      repo = "nix-zsh-completions";
      rev = "468d8cf752a62b877eba1a196fbbebb4ce4ebb6f";
      sha256 = "TWgo56l+FBXssOYWlAfJ5j4pOHNmontOEolcGdihIJs=";
    };
  };

  zsh-nix-shell = {
    name = "zsh-nix-shell";
    file = "nix-shell.plugin.zsh";
    src = pkgs.fetchFromGitHub {
      owner = "chisui";
      repo = "zsh-nix-shell";
      rev = "v0.1.0";
      sha256 = "0snhch9hfy83d4amkyxx33izvkhbwmindy0zjjk28hih1a9l2jmx";
    };
  };

in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;

    plugins = [
      zsh-nix-shell
      nix-zsh-completions
    ];

    sessionVariables = {
      "ZSH_DISABLE_COMPFIX" = "true";
      "ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE" = "fg=6";
      "ALTERNATE_EDITOR" = "";
      "VISUAL" = "nvim";
      "EDITOR" = "nvim";
      "MAKEFLAGS" = "-j4";
      "_ZO_ECHO" = "1"; # 'When set to 1, z will print the matched directory before navigating to it.
      "_ZO_RESOLVE_SYMLINKS" = "1"; # When set to 1, z will resolve symlinks before adding directories to the database.
    };

    shellAliases = {
      vactivate = "source venv/bin/activate";
      ls = "exa";
      la = "exa -lah";
      l = "exa -lh";
      tree = "exa --tree";

      dtc = "docker run --rm -ti --user 1000 --workdir /tc -v ~/tiger/tc:/tc registry.lrde.epita.fr/tiger-sid";
      nix-regenv =''echo "use nix" > .envrc; direnv allow'';
      vim = "nvim";

      cwk = "nix run -L .#check-workflow $(basename $PWD)";
    };

    initExtra = ''
      eval "$(direnv hook zsh)"
      eval "$(zoxide init --hook pwd zsh)"
      prompt_nix_shell_setup
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "colorize" "colored-man-pages" "fzf" ];
      theme = "afowler";
    };
  };
}
