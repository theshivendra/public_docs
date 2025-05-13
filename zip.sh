#!/bin/bash

echo "Hi this is Shiv"

# Always use current directory for extraction
TARGET_DIR="."

# Function to check and install a package if missing
install_if_missing() {
  local pkg="$1"
  if ! command -v "$pkg" &>/dev/null; then
    echo "$pkg not found. Installing..."
    sudo apt update && sudo apt install -y "$pkg"
  else
    echo "$pkg is already installed."
  fi
}

# Ensure required tools are installed
install_if_missing wget
install_if_missing curl
install_if_missing unzip
install_if_missing zip

# Path to zip file
DOWNLOADS_ZIP="$HOME/Downloads/script_package.zip"

# Unzip script_package.zip from ~/Downloads to current directory
if [ -f "$DOWNLOADS_ZIP" ]; then
  echo "Found 'script_package.zip' in ~/Downloads. Unzipping it here..."
  unzip -o "$DOWNLOADS_ZIP" -d "$TARGET_DIR"
  echo "✅ Unzipped 'script_package.zip' successfully to current directory."
else
  echo "⚠️ 'script_package.zip' not found in ~/Downloads. Nothing to extract."
fi
