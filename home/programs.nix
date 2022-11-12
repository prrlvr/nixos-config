{ pkgs, ... }:

{
  home.packages = with pkgs; [
    w3m

    faba-icon-theme
    gnome-icon-theme
    lm_sensors

    slrn
    # Fonts:
    meslo-lgs-nf
    font-awesome

    obs-studio
    betterlockscreen
    chromium
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
    pre-commit
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
    stack
    shellcheck

    nixpkgs-fmt
    ripgrep

    # Shell utilities
    any-nix-shell
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
    binutils
    jq

    rbw
    rofi-rbw
    xdotool

    neovim

    flameshot

    steam

    autorandr

    go

    # Formatters and language servers
    gopls
    rust-analyzer
    rustfmt
    stylua
    sumneko-lua-language-server
    texlab
    haskell-language-server
    nodePackages.pyright
    nodePackages.bash-language-server
  ];

  fonts.fontconfig.enable = true;
}
