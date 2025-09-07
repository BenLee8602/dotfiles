#!/bin/bash

# kill existing polybars
killall -q polybar
while pgrep -u "$USER" -x polybar >/dev/null; do sleep 0.1; done
echo "---" | tee /tmp/polybar*.log

# create one polybar per monitor
for monitor in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR="$monitor" polybar --reload main 2>&1 | tee -a "/tmp/polybar_$monitor.log" & disown
done

