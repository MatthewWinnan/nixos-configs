# DOCS -> https://github.com/ThePrimeagen/vim-be-good
{pkgs, ...}: {
  programs.nixvim.extraPlugins = with pkgs.vimUtils; [
    (buildVimPlugin {
      pname = "vim-be-good";
      version = "main";
      src = pkgs.fetchFromGitHub {
        owner = "ThePrimeagen";
        repo = "vim-be-good";
        rev = "4fa57b7957715c91326fcead58c1fa898b9b3625"; # Use the branch name, or you can specify a specific commit hash
        hash = "sha256-XVFq3Gb4C95Y0NYKk08ZjZaGLVF6ayPicIAccba+VRs=";
      };
    })
  ];

  # programs.nixvim.extraConfigLua = ''
  #   require('vim-be-good').setup{}
  # '';
}
