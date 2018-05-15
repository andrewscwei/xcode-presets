#!/usr/bin/env bash

{ # This ensures the entire script is downloaded

# Config.
SRC="https://raw.githubusercontent.com/andrewscwei/xcode-presets/master"

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

# Checks if a command is available.
#
# @param $1 Name of the command.
function command_exists() {
  type "$1" > /dev/null 2>&1
}

# Gets the default install path. This can be overridden when calling the
# download script by passing the INSTALL_PATH variable.
function install_dir() {
  printf %s "${INSTALL_PATH:-"$HOME/Library/Developer/Xcode/UserData"}"
}

# Installs presets.
function install_themes() {
  local dest="$(install_dir)"

  for file in ./FontAndColorThemes/*; do
    local f=${file##*/}
    local i="$SRC/FontAndColorThemes/$f"
    local o="$(install_dir)/FontAndColorThemes/$f"

    echo -e "Installing theme $i..."
    wget "$i" -O "$o" || {
      echo -e "${COLOR_RED}Failed to download from ${COLOR_CYAN}$i${COLOR_RESET}"
      return 1
    }
  done
}

# Installs presets.
function install_key_bindings() {
  local dest="$(install_dir)"

  for file in ./KeyBindings/*; do
    local f=${file##*/}
    local i="$SRC/KeyBindings/$f"
    local o="$(install_dir)/KeyBindings/$f"

    echo -e "Installing key binding $i..."
    wget "$i" -O "$o" || {
      echo -e "${COLOR_RED}Failed to download from ${COLOR_CYAN}$i${COLOR_RESET}"
      return 1
    }
  done
}

# Main process.
function main() {
  if ! command_exists wget; then
    echo -e "${COLOR_RED}You need ${COLOR_CYAN}wget${COLOR_RED} to run the install script"
    exit 1
  fi

  if [ ! -d "$(install_dir)" ]; then
    echo >&2 "${COLOR_RED}Directory ${COLOR_CYAN}$(install_dir)${COLOR_RED} not found, are you sure you have Xcode installed?${COLOR_RESET}"
    exit 1
  fi

  install_themes
  install_key_bindings

  echo -e "${COLOR_GREEN}Installation complete, restart Xcode for changes to take effect"
}

main

} # This ensures the entire script is downloaded