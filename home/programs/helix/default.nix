{inputs, ...}: {
  config.programs.helix = {
    enable = true;
    settings = {
      keys.normal = {
        space = {
          t = {
            f = "file_picker";
            b = "buffer_picker";
            s = "symbol_picker";
            d = "diagnostics_picker";
          };
        };
        G = "goto_last_line";
      };
    };
  };
}
