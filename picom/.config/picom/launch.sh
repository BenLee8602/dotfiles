#!/bin/bash

# kill existing picom processes
killall -q picom
while pgrep -u "$USER" -x polybar >/dev/null; do sleep 0.1; done
picom

