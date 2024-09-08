{lib, flakePath, config, ...}: {

  programs.wlogout = {
    enable = true;

    # We need to override stylix
    style = lib.mkOverride 20 ''
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
  background-image: image(url("${flakePath}/home/desktop/wlogout/images/lock.png"));
}

#logout {
  background-image: image(url("${flakePath}/home/desktop/wlogout/images/logout.png"));
}

#suspend {
  background-image: image(url("${flakePath}/home/desktop/wlogout/images/suspend.png"));
}

#hibernate {
  background-image: image(url("${flakePath}/home/desktop/wlogout/images/hibernate.png"));
}

#shutdown {
  background-image: image(url("${flakePath}/home/desktop/wlogout/images/shutdown.png"));
}

#reboot {
  background-image: image(url("${flakePath}/home/desktop/wlogout/images/reboot.png"));
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
