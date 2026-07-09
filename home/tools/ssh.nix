{
  config,
  lib,
  ...
}: {
  programs.ssh = lib.mkIf (config.systemSettings.profile == "work") {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      # TODO: swap all .za.netronome.com → .ci.dec.iotrap.com after DNS migration
      "*" = {
        extraOptions = {
          AddKeysToAgent = "yes";
        };
      };
      "gerrit" = {
        hostname = "gerrit.netronome.com";
        user = "mwinnan";
        port = 29418;
        extraOptions = {
          PreferredAuthentications = "publickey";
        };
      };
      "nse-services" = {
        hostname = "nse-services.ci.dec.iotrap.com";
        user = "nse";
      };
      "nse-5" = {
        hostname = "nse-5.it.dec.iotrap.com";
        user = "root";
      };
      "nse-6" = {
        hostname = "nse-6.it.dec.iotrap.com";
        user = "root";
      };
      "nse-7" = {
        hostname = "nse-7.it.dec.iotrap.com";
        user = "root";
      };
      "nse-8" = {
        hostname = "nse-8.it.dec.iotrap.com";
        user = "root";
      };
      "nse-9" = {
        hostname = "nse-9.it.dec.iotrap.com";
        user = "root";
      };
      "nse-10" = {
        hostname = "nse-10.it.dec.iotrap.com";
        user = "root";
      };
      "grys" = {
        hostname = "grys.za.netronome.com";
        user = "mwinnan";
      };
      "groenslang" = {
        hostname = "groenslang.it.dec.iotrap.com";
        user = "gitlab-runner";
      };
    };
  };
}
