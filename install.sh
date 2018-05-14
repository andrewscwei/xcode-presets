#!/usr/bin/env bash

{ # This ensures the entire script is downloaded

# Config.
SRC="https://raw.githubusercontent.com/andrewscwei/xcode-presets/master/"

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
  printf %s "${INSTALL_PATH:-"$HOME/Library/Developer/Xcode/UserData/"}"
}

# Download command (curl or wget).
function download_command() {
  if command_exists "curl"; then
    curl --compressed -q "$@"
  elif command_exists "wget"; then
    # Emulate curl with wget
    ARGS=$(echo "$*" | command sed -e 's/--progress-bar /--progress=bar /' \
                                   -e 's/-L //' \
                                   -e 's/--compressed //' \
                                   -e 's/-I /--server-response /' \
                                   -e 's/-s /-q /' \
                                   -e 's/-o /-O /' \
                                   -e 's/-C - /-c /')
    eval wget $ARGS
  fi
}

# Installs presets.
function install() {
  local dest="$(install_dir)"

  if [ ! -d "$dest" ]; then
    echo >&2 "${COLOR_RED}Directory ${COLOR_CYAN}$dest${COLOR_RED} not found, are you sure you have Xcode installed?${COLOR_RESET}"
    exit 1
  fi

  for filename in ./FontAndColorThemes/*; do
    echo "FOOOOOOO $filename"
  done

  # Download presets.
  # download_command -s "$SRC/FontAndColorThemes" -o "~/foo" || {
  #   echo -e "${COLOR_RED}Failed to download from ${COLOR_CYAN}$SRC${COLOR_RESET}"
  #   return 1
  # }
}

# Main process.
function main() {
  # Download and install the script.
  if command_exists download_command; then
    install
  else
    echo >&2 "${COLOR_RED}You need ${COLOR_CYAN}curl${COLOR_RED} or ${COLOR_CYAN}wget${COLOR_RED} to run the install script"
    exit 1
  fi

  echo -e "${COLOR_GREEN}Installation complete, restart Xcode for changes to take effect"
}

main

} # This ensures the entire script is downloaded