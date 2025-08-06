{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Utilities
    bat # cat alternative
    bottom # top alternative
    du-dust # du alternative
    duf # df alternative
    eza # ls alternative
    fd # find alternative
    fx # json viewer
    fzf # fazzy finder
    ghq # git repository manager
    httpie # http client
    imagemagick # image manipulation
    jq # json parser
    killall # process killer
    lazydocker # docker tui
    lazygit # git tui
    nh # nix cli helper
    nurl # generate nix fetcher
    procs # ps alternative
    ripgrep # grep alternative
    silicon # code to image
    speedtest-cli # speedtest
    tokei # analyze code statistics
    typos # find typos
    yazi # file manager
    htop
    graphviz
    direnv

    # Archives
    unar
    unrar
    unzip
    zip

    # Rice
    cava
    neofetch
    fastfetch
    nitch
    pfetch
    tty-clock

    # Joke
    #cowsay
    figlet
    lolcat

    qemu

    zsh
    fish
    nushell

    vivaldi
    ghostty
    lunarvim
    starship

    #fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    nerd-fonts.fira-code

    discord
    discord-ptb

    vscode

    #rustup

    obsidian

    calibre

    gnumake

    gemini-cli

    uv

  ];
}
