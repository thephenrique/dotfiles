#!/bin/bash

# DPI
#
# 96 Small (default)
# 120 Medium 125% * 2k
# 144 Larger 150% * 4k
# 192 Extra Large 200%
# 240 Custom 250%
#
# xrandr --dpi 120

MONITOR=$1

turnOnNotebookMonitor() {
  xrandr --output "eDP-1" --auto --primary --scale 1x1 --output "HDMI-1" --off --output "DP-1" --off
  sleep 2

  xrandr -s 1920x1080
  sleep 2

  xrandr --dpi 96
  sleep 2

  i3-msg restart
}

turnOnHDMI1Monitor() {
  xrandr --output "HDMI-1" --auto --primary --left-of "eDP-1" --scale 1x1 --output "eDP-1" --off --output "DP-1" --off
  sleep 2

  xrandr -s 3840x2160
  sleep 2

  xrandr --dpi 144
  sleep 2

  i3-msg restart
}

turnOnBothMonitors() {
  xrandr --output "HDMI-1" --auto --primary --left-of "eDP-1" --scale 1x1 --output "eDP-1" --auto
  sleep 2

  xrandr --dpi 144
  sleep 2

  i3-msg restart
}

if [[ "$MONITOR" == "notebook" ]]; then
  turnOnNotebookMonitor
  exit 0
fi

if [[ "$MONITOR" == "hdmi-1" ]]; then
  turnOnHDMI1Monitor
  exit 0
fi

if [[ "$MONITOR" == "both" ]]; then
  turnOnBothMonitors
  exit 0
fi

echo "Please, specify the monitor: notebook, hdmi-1, both."
