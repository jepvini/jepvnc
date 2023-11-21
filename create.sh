#!/usr/bin/env bash

XRES=2700 # x resolution
YRES=2000 # y resolution

# the default position is on the left of the main display

# sway uses create_output to create a virtual out, and it call it HEADLESS-N, where N is the number of virtual desktop
# created since the sway is launched, but the device name is needed to bind to out to a device
# my questionable workaround is to create a virtual out, get its number, create a rule for the HEADLESS-N+1 out,
# create a new out and it works

swaymsg create_output # dummy out
NUM="$(swaymsg -t get_outputs | grep HEADLESS | awk '{print $2;}' | sed 's/,//' | sed 's/"//g' | sed 's/-/ /' | awk '{print $2;}')" # get out number
swaymsg "output HEADLESS-$NUM unplug" # delete out
NUM=$((NUM + 1)) # get next out
swaymsg "workspace 10 output HEADLESS-$NUM" # create rule
swaymsg create_output # create real out
swaymsg "output HEADLESS-$NUM pos 0 0 res ${XRES}x${YRES}" # set resolution


wayvnc # lauch wayvnc
