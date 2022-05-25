{ pkgs, ... }:

{
  home.packages = with pkgs; [
  teamviewer

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

    nixpkgs-fmt
    ripgrep

    # Shell utilities
    bottom
    zathura
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
    jq

    neovim

    flameshot

    # Formatters and language servers
    rust-analyzer
    rustfmt
    stylua
    sumneko-lua-language-server
    texlab
  ];

  fonts.fontconfig.enable = true;
}
