echo "Hi this is Shiv"
#!/bin/bash

ZIP_URL="$1"
ZIP_NAME="$2"
TARGET_DIR="$3"

# Check for required arguments
if [ -z "$ZIP_URL" ] || [ -z "$ZIP_NAME" ] || [ -z "$TARGET_DIR" ]; then
  echo "Usage: $0 <zip_url> <output_zip_name> <target_directory>"
  exit 1
fi

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

# Check and unzip script_package.zip from ~/Downloads to current directory
DOWNLOADS_ZIP="$HOME/Downloads/script_package.zip"
if [ -f "$DOWNLOADS_ZIP" ]; then
  echo "Found 'script_package.zip' in ~/Downloads. Unzipping it here..."
  unzip -o "$DOWNLOADS_ZIP" -d .
else
  echo "'script_package.zip' not found in ~/Downloads. Skipping unzip."
fi

# Download ZIP file if not already present
if [ -f "$ZIP_NAME" ]; then
  echo "ZIP file '$ZIP_NAME' already exists. Skipping download."
else
  echo "Downloading ZIP file from $ZIP_URL..."
  wget -O "$ZIP_NAME" "$ZIP_URL"
fi

# Create the target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Unzip downloaded ZIP into the target directory
echo "Unzipping '$ZIP_NAME' to '$TARGET_DIR'..."
unzip -o "$ZIP_NAME" -d "$TARGET_DIR"

echo "✅ Done: All steps completed successfully."
