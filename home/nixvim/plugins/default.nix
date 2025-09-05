{
  # このファイルからインポートされる設定が
  # 自動的に programs.nixvim の中に配置されるようにする
  programs.nixvim = {
    imports = [
      ./autopairs.nix
      ./blink-cmp.nix
      ./lsp.nix
      ./which-key.nix
      ./conform.nix
      ./neo-tree.nix
      ./telescope.nix
      ./treesitter.nix
      ./lint.nix
      ./debug.nix
      ./mini.nix # もっといじれる
      ./copilot-chat.nix
    ];
  };
}
