# https://github.com/ThePrimeagen/harpoon
{
  programs.nixvim.plugins.harpoon = {
    enable = true;
    enableTelescope = true;
  };

  # Keymaps within harpoon no longer do anything since they migrated to harpoon2
  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>ha";
      action.__raw = "function() require'harpoon':list():add() end";
      options.desc = "Add a file to harpoon2";
    }
    {
      mode = "n";
      key = "<leader>hp";
      action.__raw = "function() require'harpoon'.ui:toggle_quick_menu(require'harpoon':list()) end";
      options.desc = "Open up harpoon2 quick_menu";
    }
    {
      mode = "n";
      key = "<leader>hh";
      action.__raw = "function() require'harpoon':list():select(1) end";
      options.desc = "Quick nav harpoon2 file 1";
    }
    {
      mode = "n";
      key = "<leader>hj";
      action.__raw = "function() require'harpoon':list():select(2) end";
      options.desc = "Quick nav harpoon2 file 2";
    }
    {
      mode = "n";
      key = "<leader>hk";
      action.__raw = "function() require'harpoon':list():select(3) end";
      options.desc = "Quick nav harpoon2 file 3";
    }
    {
      mode = "n";
      key = "<leader>hl";
      action.__raw = "function() require'harpoon':list():select(4) end";
      options.desc = "Quick nav harpoon2 file 4";
    }
  ];
}
