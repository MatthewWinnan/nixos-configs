{
  programs.nixvim.plugins.schemastore = {
    enable = true;
    json.enable = false;

    yaml = {
      enable = true;
      settings = {
        extra = [
          {
            description = "IfState 1.13 Configuration Schema";
            name = "ifstate.conf";
            url = "https://ifstate.net/schema/1.13/ifstate.conf.schema.json";
          }
          {
            description = "ZMK Hardware Schema";
            name = "hardware-metadata.schema.json";
            url = "https://github.com/MatthewWinnan/zmk-facehugger/blob/main/schema/hardware-metadata.schema.json";
          }
        ];
      };
    };
  };
}
