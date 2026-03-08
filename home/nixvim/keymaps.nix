{
  programs.nixvim.keymaps = [
    {
      key = "<leader>ff";
      action = "<cmd>Telescope find_files<CR>";
      options.desc = "Find files";
    }
    {
      key = "L";
      action = "$";
    }
    {
      key = "H";
      action = "^";
    }
    {
      key = "m";
      action = "%";
    }
    {
      mode = "n";
      key = "<esc><esc>";
      action = "<cmd>nohlsearch<CR>";
    }
    {
      mode = "n";
      key = "x";
      action = "\"_x";
      options = {
        noremap = true;
        silent = true;
      };
    }
  ];
}
