{ pkgs, ... }:
{
  home = {
    # recでAttribute Set内で他の値を参照できるようにする
    username = "watanabe";
    homeDirectory = "/home/watanabe"; # 文字列に値を埋め込む
    stateVersion = "24.11";
  };
  programs.home-manager.enable = true; # home-manager自身でhome-managerを有効化

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
    pingu

    #qemu
    qemu

    neovim
    zsh
    fish
    nushell

    vivaldi
    ghostty

    lunarvim
  ];

  # input method
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
      fcitx5-configtool
    ];
  };

  home.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    GLFW_IM_MODULE = "ibus";  # Kittyなどのターミナル用
  };

  home.keyboard = {
    options = [ "ctrl:nocaps" ];
  };
  dconf.settings = {
  "org.gnome.desktop.input-sources" = {
    xkb-options = ["ctrl:nocaps"];
  };
};

}
