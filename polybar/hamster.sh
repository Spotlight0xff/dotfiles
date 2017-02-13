#!/bin/bash

activity=$(hamster current | cut -d' ' -f 3- | sed 's/@.* / - /')

# Foreground color formatting tags are optional
if [[ -n $activity ]]; then
    echo "%{F#B48EAD}$activity"    # Match icon color
else
  echo "%{F#65737E}No Activity"  # Greyed out
fi
