#!/bin/bash

CACHE_FILE="$HOME/.cache/redshift-location"

TEMP_DAY=5000
TEMP_NIGHT=2500

BRIGHT_DAY=1.0
BRIGHT_NIGHT=0.8

killall -q redshift
while pgrep -u "$USER" -x redshift >/dev/null; do sleep 0.1; done
redshift -x

res=$(curl -s --max-time 8 https://ipinfo.io/loc)

if [[ $res =~ ^[0-9.-]+,[0-9.-]+$ ]]; then
    echo "$res" > "$CACHE_FILE"
    lat="${res%,*}"
    lon="${res#*,}"
    echo "redshift is using online location"
else
    if [[ -f "$CACHE_FILE" ]]; then
        cached=$(cat "$CACHE_FILE")
        lat="${res%,*}"
        lon="${res#*,}"
        echo "redshift is using cached location"
    else
        lat=43.6532
        lon=-79.3832
        echo "redshift is using default location"
    fi
fi

echo "$lat:$lon"
redshift -l "$lat:$lon" -t "$TEMP_DAY:$TEMP_NIGHT" -b "$BRIGHT_DAY:$BRIGHT_NIGHT" & disown

