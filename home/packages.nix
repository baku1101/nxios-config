{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Utilities
    bat # cat alternative
    bottom # top alternative
    dust # du alternative
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
    speedtest-cli # speedtest
    tokei # analyze code statistics
    typos # find typos
    nodePackages.markdownlint-cli # for markdown linting
    yazi # file manager
    spacedrive # GUI file manager
    xclip # clipboard manager
    # libsForQt5.okular # pdf viewer
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
    fastfetch
    nitch
    pfetch
    tty-clock

    qemu

    zsh
    fish
    nushell

    vivaldi
    ghostty
    lunarvim
    starship

    zoom-us

    #fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
    source-han-code-jp

    discord
    discord-ptb

    vscode

    #rustup

    obsidian

    calibre

    gnumake

    # gemini-cli
    codex

    uv

    # require hyprland
    pipewire # 画面共有
    wireplumber
    hypridle

    # cursor
    bibata-cursors
  ];
}
