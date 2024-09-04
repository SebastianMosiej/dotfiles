#!/bin/bash
#
#
xrandrOut=$(xrandr)
activeDisplays=$(echo "${xrandrOut}" | grep -w connected | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/" | tr '\n' ' ' | sort)

if [[ $activeDisplays =~ "DP-1-8" ]]; then
  echo "Work setup"
  sed -i "s|^#\(set \$primary DP-1-8\)$|\1|;s|^#\(set \$secondary DP-1-1-8\)|\1|;s|^\(set \$primary HDMI-1\)|#\1|;s|^\(set \$secondary DP-1\)$|#\1|" ~/.config/i3/config
  autorandr -l three_monitors_work
elif [[ $activeDisplays =~ "HDMI-1" ]]; then
  echo "Home setup"
  sed -i "s|^\(set \$primary DP-1-8\)$|#\1|;s|^\(set \$secondary DP-1-1-8\)|#\1|;s|^#\(set \$primary HDMI-1\)|\1|;s|^#\(set \$secondary DP-1\)$|\1|" ~/.config/i3/config
  autorandr -l three_monitors_home
fi
i3-msg reload
i3-msg restart
