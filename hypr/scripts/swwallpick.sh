#!/bin/bash

wall_scr=$HOME/.config/hypr/scripts/swwallchange.sh

selected="$(ls "$HOME/.config/swww/" | sort | rofi -dmenu -hover-select -me-select-entry '' -me-accept-entry MousePrimary)"

$wall_scr $selected
