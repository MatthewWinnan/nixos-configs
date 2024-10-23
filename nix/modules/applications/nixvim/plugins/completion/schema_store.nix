{
  programs.nixvim.plugins.schemastore = {
    enable = true;
    json.enable = false;

    yaml = {
      enable = true;
      settings = {
       extra = [{
          description = "IfState 1.13 Configuration Schema";
          name = "ifstate.conf";
          url = "https://ifstate.net/schema/1.13/ifstate.conf.schema.json";
        }];
      };
    };
  };
}

