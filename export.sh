#!/bin/bash

SRC="$HOME/Library/Developer/Xcode/UserData"

# Colors.
COLOR_PREFIX="\x1b["
COLOR_RESET=$COLOR_PREFIX"0m"
COLOR_BLACK=$COLOR_PREFIX"0;30m"
COLOR_RED=$COLOR_PREFIX"0;31m"
COLOR_GREEN=$COLOR_PREFIX"0;32m"
COLOR_ORANGE=$COLOR_PREFIX"0;33m"
COLOR_BLUE=$COLOR_PREFIX"0;34m"
COLOR_PURPLE=$COLOR_PREFIX"0;35m"
COLOR_CYAN=$COLOR_PREFIX"0;36m"
COLOR_LIGHT_GRAY=$COLOR_PREFIX"0;37m"

function export_themes() {
  for file in $SRC/FontAndColorThemes/*; do
    local f=${file##*/}
    local o="./FontAndColorThemes/$f"

    echo -e "Exporting theme ${COLOR_CYAN}$f${COLOR_RESET}..."

    cp -rf "$file" "$o"
  done
}

function export_key_bindings() {
  for file in $SRC/KeyBindings/*; do
    local f=${file##*/}
    local o="./KeyBindings/$f"

    echo -e "Exporting key binding ${COLOR_CYAN}$f${COLOR_RESET}..."

    cp -rf "$file" "$o"
  done
}

export_themes
export_key_bindings