#!/bin/bash
pac=$(checkupdates | wc -l)
aur=$(cower -q -u | wc -l)

check=$((pac + aur))
if [[ "$check" != "0" ]]
then
  echo "$pac %{F#5b5b5b}%{F-} $aur"
fi
