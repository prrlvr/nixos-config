{ pkgs, ... }:

{
  home.packages = with pkgs; [
    faba-icon-theme
    gnome-icon-theme
    lm_sensors

    # Fonts:
    meslo-lgs-nf
    font-awesome

    obs-studio
    betterlockscreen
    discord
    feh
    gnupg
    pinentry # dependency of gnupg
    pavucontrol
    spotify
    slack
    teams
    thunderbird
    vlc
    mpv
    qbittorrent

    man-pages
    man-db

    # System
    autorandr # TODO config
    xautolock
    xss-lock
    wireguard-tools

    # Dev tools
    docker
    docker-compose
    flex
    gdb
    pre-commit
    autoconf
    libtool
    tig
    valgrind
    gnumake
    bear

    # DoomEmacs dependencies
    # nixfmt
    nixpkgs-fmt
    ripgrep

    # Shell utilities
    bottom
    direnv
    exa
    escrotum
    fzf
    zoxide
    neofetch
    unzip
    xclip
    nix-zsh-completions
    clang-tools

    neovim

    # Formatters and language servers
    nixpkgs-fmt
    rust-analyzer
    rustfmt
    stylua
    sumneko-lua-language-server
    texlab
  ];

  fonts.fontconfig.enable = true;
}
