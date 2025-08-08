{ pkgs,nixvim,kickstart-nixvim, ... }:
{
  imports = [
    ./packages.nix
    ./zsh.nix
    ./starship.nix
    ./input-method.nix
    ./dconf.nix
    ./wm/hyprland/default.nix
    nixvim.homeManagerModules.nixvim
    ./nixvim/default.nix
    #kickstart-nixvim.homeManagerModules.default
  ];

  home = {
    # recでAttribute Set内で他の値を参照できるようにする
    username = "watanabe";
    homeDirectory = "/home/watanabe"; # 文字列に値を埋め込む
    stateVersion = "25.11";
  };
  programs.home-manager.enable = true; # home-manager自身でhome-managerを有効化

  fonts.fontconfig.enable = true;

  programs.nixvim.enable = true;
}