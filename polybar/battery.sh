#!/bin/bash

battery_path="/sys/class/power_supply/BAT1/capacity"
battery=$(cat $battery_path 2>/dev/null)
echo "$battery%"

