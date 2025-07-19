# Currently there exists some issues with how freecad interacts with WAYLAND
# Look at the following:
# https://forum.freecad.org/viewtopic.php?t=89408
# https://forum.freecad.org/viewtopic.php?style=10&t=93956
# This will serve as a shell that sets the needed work arounds to get freecad more stable
{pkgs, ...}:
pkgs.mkShell {
  shellHook = ''
    echo "Setting Environment Variables"

    # One of the solutions was the unset WAYLAND_DISPLAY
    export WAYLAND_DISPLAY=

    # The other solution was to set QT_QPA_PLATFORM to xcb to allow freecad to render through xwayland
    export QT_QPA_PLATFORM=xcb
  '';
}
