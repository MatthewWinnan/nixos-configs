# https://github.com/ThePrimeagen/harpoon
{
  programs.nixvim.plugins.harpoon = {
    enable = true;
    enableTelescope = true;
    keymapsSilent = true;
    keymaps = {
      addFile = "<leader>ha";
      toggleQuickMenu = "<leader>hp";
      navFile = {
        "1" = "<leader>hj";
        "2" = "<leader>hk";
        "3" = "<leader>hl";
        "4" = "<leader>hm";
      };
    };
  };
}
