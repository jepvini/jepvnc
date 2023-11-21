#!/usr/bin/env bash

OUT="$(swaymsg -t get_outputs | grep HEADLESS | awk '{print $2;}' | sed 's/,//' | sed 's/"//g')"
for out in $OUT
do
  echo "$out"
  swaymsg output "$out" unplug
done
