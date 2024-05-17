#!/bin/bash

# Set primary monitor.
xrandr --output "HDMI-1" --primary --left-of "eDP-1" --scale 1x1
sleep 3

# Set resolution and DPI on primary monitor.
xrandr --output "HDMI-1" -s 3840x2160
sleep 3
xrandr --dpi 144
# xrandr --output "HDMI-1" --dpi 144
sleep 3

# Set resolution and DPI on notebook monitor.
xrandr --output "eDP-1" -s 1920x1080
sleep 3
# xrandr --output "eDP-1" --dpi 96
sleep 3

# Disable USB-C monitors.
xrandr --output "DP-1" --off
sleep 3
xrandr --output "DP-2" --off
sleep 3

i3-msg restart
