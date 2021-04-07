#!/bin/bash

if [[ $(xrandr | grep connected | grep -cv disconnected) -ge 2 ]]; then
    export MULTIMONITOR=1
else
    export MULTIMONITOR=0
fi

# This directory
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd)"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $USER -x polybar >/dev/null; do sleep 1; done

# Launch bars
echo "MULTIMONITOR is: $MULTIMONITOR"
if [[ $MULTIMONITOR -eq 1 ]]; then
    polybar -c "$DIR"/config top-primary &
    polybar -c "$DIR"/config top-secondary &
else
    MONITORPRIMARY=$MONITORSECONDARY
    polybar -c "$DIR"/config top-primary &
fi

echo "Bars launched..."