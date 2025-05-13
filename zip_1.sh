#!/bin/bash
echo "Hello"
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

# URL to the GitHub zip file
ZIP_URL="https://github.com/theshivendra/public_docs/raw/main/script_package.zip"
ZIP_NAME="script_package.zip"

# Path to download location
DOWNLOAD_DIR="$HOME/Downloads"

# Check if script_package.zip exists in the GitHub repo
if curl --head --silent --fail "$ZIP_URL" > /dev/null; then
  echo "Found 'script_package.zip' on GitHub. Downloading it..."
  wget -q -O "$DOWNLOAD_DIR/$ZIP_NAME" "$ZIP_URL"
  echo "✅ Downloaded 'script_package.zip' successfully from GitHub."
else
  echo "⚠️ 'script_package.zip' not found on GitHub. Nothing to download."
  exit 1
fi

# Unzip the downloaded zip file to the current directory
if [ -f "$DOWNLOAD_DIR/$ZIP_NAME" ]; then
  echo "Unzipping 'script_package.zip' from GitHub to current directory..."
  unzip -o "$DOWNLOAD_DIR/$ZIP_NAME" -d "$TARGET_DIR"
  echo "✅ Unzipped 'script_package.zip' successfully to current directory."
else
  echo "⚠️ Downloaded zip file 'script_package.zip' not found. Nothing to extract."
  exit 1
fi
