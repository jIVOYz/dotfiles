#!/bin/bash

styles="#window {location: northwest;width: 320px; height: 40%;} sidebar {enabled: false;} listview {columns: 1;}"

# selected=$(printf "  Power off\n  Restart\n  Lock" | rofi -dmenu -hover-select -me-select-entry '' -me-accept-entry MousePrimary -theme-str "$styles")
rofi -show drun -hover-select -no-click-to-exit -me-select-entry '' -me-accept-entry MousePrimary -theme-str "$styles"
