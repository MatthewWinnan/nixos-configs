{
  lib,
  flakePath,
  config,
  ...
}: {
  programs.wlogout = lib.mkForce {
    enable = true;

    # We need to override stylix
    style = ''
          * {
        background-image: none;
      }

      window {
        background-color: rgba(36, 39, 58, 0.9);
      }

      button {
        margin: 8px;
        color: #cad3f5;
        background-color: #363a4f;
        border-style: solid;
        border-width: 2px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
      }

      button:active,
      button:focus,
      button:hover {
        color: #8bd5ca;
        background-color: #24273a;
        outline-style: none;
      }

      #lock {
        background-image: image(url("${config.images.wlogout_lock}"));
      }

      #logout {
        background-image: image(url("${config.images.wlogout_logout}"));
      }

      #suspend {
        background-image: image(url("${config.images.wlogout_suspend}"));
      }

      #hibernate {
        background-image: image(url("${config.images.wlogout_hibernate}"));
      }

      #shutdown {
        background-image: image(url("${config.images.wlogout_shutdown}"));
      }

      #reboot {
        background-image: image(url("${config.images.wlogout_reboot}"));
      }
    '';
    layout = [
      {
        label = "lock";
        action = "hyprlock";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "logout";
        action = "loginctl terminate-user $USER";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
    ];
  };
}
