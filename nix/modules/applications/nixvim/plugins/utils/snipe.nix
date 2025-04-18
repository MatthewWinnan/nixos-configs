# Snipe has not been released yet/no packages, we keep this for now when they do??
# Location is at https://github.com/leath-dub/snipe.nvim
{pkgs, ...}: {
  programs.nixvim.extraPlugins = with pkgs.vimUtils; [
    (buildVimPlugin {
      pname = "snipe.nvim";
      version = "main";
      src = pkgs.fetchFromGitHub {
        owner = "leath-dub";
        repo = "snipe.nvim";
        rev = "f1abd4aaaef6398b45dcddc9f1a40dd982f732b0"; # Use the branch name, or you can specify a specific commit hash
        hash = "sha256-G4g/OzyXhDhX84HkxlhFSy6E+EAGxH+HL1Bw5s5FWHE=";
      };
    })
  ];

  programs.nixvim.extraConfigLua = ''
    require("snipe").setup();
  '';

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>ss";
      action = "<cmd>lua require('snipe').open_buffer_menu()<cr>";
      options = {
        desc = "Open Snipe Buffer Menu";
      };
    }
  ];
}
