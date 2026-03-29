{
  inputs,
  config,
  ...
}:
{
  config.programs.claude-code = {
    enable = config.systemSettings.profile == "personal" || config.systemSettings.profile == "gaming";
    mcpServers = {
      filesystem = {
        command = "npx";
        args = [
          "-y"
          "@modelcontextprotocol/server-filesystem"
          "/home/matthew"
        ];
        timeout = 300000;
      };

      nixos = {
        command = "nix";
        args = [
          "run"
          "github:utensils/mcp-nixos"
          "--"
        ];
        timeout = 300000;
      };
    };
  };
}
