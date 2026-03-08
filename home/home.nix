{
  pkgs,
  inputs,
  nixvim,
  hyprland,
  ...
}:
{
  imports = [
    inputs.ags.homeManagerModules.default
    ./packages.nix
    ./zsh.nix
    ./starship.nix
    ./input-method.nix
    ./dconf.nix
    ./rust.nix
    ./wm/hyprland/default.nix
    nixvim.homeModules.nixvim
    ./nixvim/default.nix
  ];

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  home = {
    # recでAttribute Set内で他の値を参照できるようにする
    username = "watanabe";
    homeDirectory = "/home/watanabe"; # 文字列に値を埋め込む
    stateVersion = "25.11";
  };
  programs.home-manager.enable = true; # home-manager自身でhome-managerを有効化

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.ghostty = {
    enable = true;
    settings = {
      # 英数字はJetBrains Monoに担当させる
      font-family = "JetBrainsMonoNL Nerd Font Mono";
      font-feature = "-dlig";
      font-size = "12";
    };
  };

  programs.nixvim.enable = true;
}
