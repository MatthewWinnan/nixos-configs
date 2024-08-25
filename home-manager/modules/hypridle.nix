{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
      before_sleep_cmd = "loginctl lock-session";    # lock before suspend.
      after_sleep_cmd = "hyprctl dispatch dpms on";
      ignore_dbus_inhibit = false;
      lock_cmd = "pidof hyprlock || hyprlock"; # Avoid starting multiple of the same
        };

      listener = [
      {
        timeout = 300;# 5 min
        on-timeout = "hyprlock";
        }
      {
        timeout = 480;                                 # 8min
        on-timeout = "loginctl lock-session";            # lock screen when timeout has passed
        }
      {
        timeout = 900; # 15 min
        on-timeout = "hyprctl dispatch dpms off";
        on-resume = "hyprctl dispatch dpms on";
        }
      {
        timeout = 1800;                                # 30min
        on-timeout = "systemctl suspend";               # suspend pc
        }
      ];

    };

  };
}
