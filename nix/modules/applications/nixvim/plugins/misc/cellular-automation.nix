# DOCS -> https://github.com/Eandrju/cellular-automaton.nvim
{pkgs, ...}: {
  programs.nixvim.extraPlugins = with pkgs.vimUtils; [
    (buildVimPlugin {
      pname = "cellular-automation";
      version = "main";
      src = pkgs.fetchFromGitHub {
        owner = "Eandrju";
        repo = "cellular-automaton.nvim";
        rev = "11aea08aa084f9d523b0142c2cd9441b8ede09ed"; # Use the branch name, or you can specify a specific commit hash
        hash = "sha256-nIv7ISRk0+yWd1lGEwAV6u1U7EFQj/T9F8pU6O0Wf0s=";
      };
    })
  ];

  programs.nixvim.extraConfigLua = ''
        local config = {
        fps = 50,
        name = 'slide',
    }

    -- init function is invoked only once at the start
    -- config.init = function (grid)
    --
    -- end

    -- update function
    config.update = function (grid)
        for i = 1, #grid do
            local prev = grid[i][#(grid[i])]
            for j = 1, #(grid[i]) do
                grid[i][j], prev = prev, grid[i][j]
            end
        end
        return true
    end

    require("cellular-automaton").register_animation(config)
  '';
}
