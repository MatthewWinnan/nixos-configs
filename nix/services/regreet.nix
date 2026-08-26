# ReGreet greeter running inside Hyprland for proper multi-monitor support.
# The NixOS programs.regreet module handles the regreet binary and config;
# we override the greetd command to use Hyprland instead of Cage so monitors
# get their native resolution.
{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  greeter = config.deviceSettings.greeter;
  isRegreet = greeter == "regreet" && !config.deviceSettings.headless;

  # Format a float cleanly (reuse logic from hyprland.nix)
  fmtFloat = rate: let
    raw = toString rate;
    parts = lib.splitString "." raw;
    intPart = builtins.elemAt parts 0;
    fracRaw =
      if builtins.length parts > 1
      then builtins.elemAt parts 1
      else "";
    fracStripped =
      lib.strings.removeSuffix "0"
      (lib.strings.removeSuffix "0"
        (lib.strings.removeSuffix "0"
          (lib.strings.removeSuffix "0"
            (lib.strings.removeSuffix "0"
              (lib.strings.removeSuffix "0" fracRaw)))));
  in
    if fracStripped == ""
    then intPart
    else "${intPart}.${fracStripped}";

  # Generate a hl.monitor() lua call for the greeter (simplified — no HDR/CM)
  monitorToGreeterLua = m:
    if m.enabled
    then ''
      hl.monitor({
        output = "${m.name}",
        mode = "${toString m.width}x${toString m.height}@${fmtFloat m.refreshRate}",
        position = "${m.position}",
        scale = 1,
        transform = ${m.rotate_mode},
      })
    ''
    else ''
      hl.monitor({
        output = "${m.name}",
        disabled = true,
      })
    '';

  hyprlandPkg = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

  isVM = config.deviceSettings.type == "vm";

  # The greeter lua config
  greeterLua = ''
    -- Hyprland greeter config (auto-generated)
    -- Minimal session that runs ReGreet then exits

    ${lib.concatStringsSep "\n" (map monitorToGreeterLua config.deviceSettings.monitors)}

    ${lib.optionalString isVM ''
    hl.env("LIBGL_ALWAYS_SOFTWARE", "1")
    hl.env("WLR_RENDERER_ALLOW_SOFTWARE", "1")
    hl.env("AQ_NO_MODIFIERS", "1")
    hl.env("AQ_MGPU_NO_EXPLICIT", "1")
    ''}

    hl.config({
      misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        force_default_wallpaper = 0,
      },
      animations = {
        enabled = false,
      },
      input = {
        kb_layout = "us",
      },
    })

    ${lib.optionalString isVM ''
    hl.config({
      cursor = {
        no_hardware_cursors = true,
        use_cpu_buffer = true,
      },
    })
    ''}

    hl.env("XCURSOR_SIZE", "24")
    hl.env("XCURSOR_THEME", "BreezeX-RosePine-Linux")

    -- Wait for the Wayland display to be ready before launching regreet.
    -- If regreet exits non-zero (crash), don't kill Hyprland immediately
    -- to avoid a rapid restart loop with greetd.
    hl.on("hyprland.start", function()
      hl.exec_cmd("${lib.getExe config.programs.regreet.package} && ${hyprlandPkg}/bin/hyprctl dispatch exit")
    end)
  '';
in {
  config = lib.mkIf isRegreet {
    programs.regreet = {
      enable = true;
      settings = {
        background = {
          path = lib.mkForce "${config.images.regreet_background}";
          fit = "Cover";
        };
        GTK.application_prefer_dark_theme = true;
        appearance.greeting_msg = "Welcome back!";
      };
    };

    # Override greetd to use Hyprland instead of Cage
    services.greetd.settings.default_session.command = lib.mkForce
      "${hyprlandPkg}/bin/Hyprland --config /etc/greetd/hyprland-greeter.lua";

    # Write the greeter Hyprland config
    environment.etc."greetd/hyprland-greeter.lua" = {
      text = greeterLua;
      mode = "0644";
    };
  };
}
