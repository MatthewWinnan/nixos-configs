# DOCS -> https://github.com/AUNaseef/protonup
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    protonup-ng
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };
}
