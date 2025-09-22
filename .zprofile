# Startup Hyprland.
# if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
#   exec Hyprland
# fi

# Startup Hyprland with uwsm.
if [[ -z $WAYLAND_DISPLAY ]] && uwsm check may-start; then
    exec uwsm start hyprland-uwsm.desktop
fi
