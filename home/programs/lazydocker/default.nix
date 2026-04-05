# https://github.com/jesseduffield/lazydocker
{
  config,
  ...
}: {
  programs.lazydocker = {
    enable = config.systemSettings.profile == "work";

    settings = {
      # GUI settings
      gui = {
        scrollHeight = 2;
        language = "auto";
        theme = {
          activeBorderColor = ["blue" "bold"];
          inactiveBorderColor = ["default"];
          selectedLineBgColor = ["default"];
        };
        showAllContainers = true;
        returnImmediately = true;
        wrapMainPanel = true;
      };

      # Logging settings
      logs = {
        timestamps = true;
        since = "1h";
        tail = 200;
      };

      # Confirmation prompts
      confirmOnQuit = false;

      # Stats settings
      stats = {
        graphs = [
          {
            caption = "CPU (%)";
            statPath = "DerivedStats.CPUPercentage";
            color = "blue";
          }
          {
            caption = "Memory (%)";
            statPath = "DerivedStats.MemoryPercentage";
            color = "green";
          }
        ];
      };

      # Custom command templates
      commandTemplates = {
        dockerCompose = "docker compose";
        restartService = "{{ .DockerCompose }} restart {{ .Service.Name }}";
        stopService = "{{ .DockerCompose }} stop {{ .Service.Name }}";
        serviceLogs = "{{ .DockerCompose }} logs --since=1h --follow {{ .Service.Name }}";
        allLogs = "{{ .DockerCompose }} logs --tail=300 --follow";
      };

      # OS-specific commands
      oS = {
        openCommand = "xdg-open {{filename}}";
        openLinkCommand = "xdg-open {{link}}";
      };
    };
  };
}
