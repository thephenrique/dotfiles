#!/bin/bash

# The single monitor.
xrandr \
  --output "HDMI-1" --primary --left-of "eDP-1" --scale 1x1 \
  --output "eDP-1" --off \
  --output "DP-1" --off \
  --output "DP-2" --off
sleep 2

xrandr -s 3840x2160
# xrandr -s 2560x1440
sleep 2

# 96 Small (default)
# 120 Medium 125% *
# 144 Larger 150%
# 192 Extra Large 200%
# 240 Custom 250%
xrandr --dpi 144
sleep 2

i3-msg restart
