#!/bin/bash

# Configuration variables
COUNTRY="UK"                               # Set the country code (e.g., US, UK, IN)
LOCALE="en-GB"                             # Set the locale (e.g., en-GB)
ORIENTATION="landscape"                    # Set orientation: "landscape" or "portrait"
OUTPUT_DIR="$HOME/pictures/BingWallpapers" # Directory to save images
MAX_IMAGES=5                               # Maximum number of images to keep
SESSION=""                                 # Variable to store the session argument

# API endpoint
API_URL="https://fd.api.iris.microsoft.com/v4/api/selection?placement=88000820&bcnt=1&country=$COUNTRY&locale=$LOCALE&fmt=json"

# Set a User-Agent to avoid "No ad available" issue
USER_AGENT="Mozilla/5.0"

# Function to display help message
show_help() {
  echo "Usage: $0 [options]"
  echo "Options:"
  echo "  --country <country_code>  Set the country code (default: UK)"
  echo "  --locale <locale_code>    Set the locale (default: en-GB)"
  echo "  --orientation <orientation> Set orientation ('landscape' or 'portrait', default: landscape)"
  echo "  --output_dir <directory>  Set the output directory (default: $OUTPUT_DIR)"
  echo "  --max_images <number>     Set the maximum number of images to keep (default: $MAX_IMAGES)"
  echo "  --session <session_type>  Specify the session type ('hyprland', 'i3')"
  echo "  --help                    Show this help message"
  exit 0
}

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
  --country=*)
    COUNTRY="${1#*=}"
    shift
    ;;
  --locale=*)
    LOCALE="${1#*=}"
    shift
    ;;
  --orientation=*)
    ORIENTATION="${1#*=}"
    shift
    ;;
  --output_dir=*)
    OUTPUT_DIR="${1#*=}"
    shift
    ;;
  --max_images=*)
    MAX_IMAGES="${1#*=}"
    shift
    ;;
  --session=*)
    SESSION="${1#*=}"
    shift
    ;;
  --help)
    show_help
    ;;
  *)
    echo "Unknown option: $1"
    show_help
    ;;
  esac
done

# --- Fetch and Download New Image ---
# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Fetch JSON response from the API
RESPONSE=$(curl -s -A "$USER_AGENT" "$API_URL")

# Extract image URL based on orientation
if [ "$ORIENTATION" == "landscape" ]; then
  IMAGE_URL=$(echo "$RESPONSE" | jq -r '.batchrsp.items[0].item | fromjson | .ad.landscapeImage.asset')
elif [ "$ORIENTATION" == "portrait" ]; then
  IMAGE_URL=$(echo "$RESPONSE" | jq -r '.batchrsp.items[0].item | fromjson | .ad.portraitImage.asset')
else
  echo "Invalid orientation. Use 'landscape' or 'portrait'."
  exit 1
fi

# Check if IMAGE_URL was extracted successfully
if [ -z "$IMAGE_URL" ] || [ "$IMAGE_URL" == "null" ]; then
  echo "Failed to retrieve image URL."
  exit 1
fi

# Determine the filename from the URL
FILENAME=$(basename "$IMAGE_URL")
OUTPUT_PATH="$OUTPUT_DIR/$FILENAME"

# Download the image
curl -s -o "$OUTPUT_PATH" "$IMAGE_URL"

# Confirm download success
if [ $? -ne 0 ]; then
  echo "Failed to download image."
  exit 1
fi

echo "Image downloaded successfully to: $OUTPUT_PATH"

find "$OUTPUT_DIR" -maxdepth 1 -type f -printf '%T@\t%p\n' | sort -n | head -n "$(($(find "$OUTPUT_DIR" -maxdepth 1 -type f | wc -l) - MAX_IMAGES))" | cut -f 2- | while IFS= read -r file; do
  echo "Removing old image: $file"
  rm "$file"
done

UNAME=$(uname -s)

if [ "$UNAME" == "Linux" ]; then
  case "$SESSION" in
  hyprland)
    echo "Setting wallpaper for Hyprland..."
    hyprctl hyprpaper unload all
    hyprctl hyprpaper preload "$OUTPUT_PATH"
    hyprctl hyprpaper wallpaper ",$OUTPUT_PATH"
    cp -f $OUTPUT_PATH $HOME/.cache/current-wallpaper.jpg
    echo "Hyprland wallpaper set to: $OUTPUT_PATH"
    ;;
  i3)
    echo "Setting wallpaper for i3..."
    DISPLAY=:0.0 feh --bg-fill "$OUTPUT_PATH"
    echo "i3 wallpaper set to: $OUTPUT_PATH"
    ;;
  "") # If --session is not provided, fallback to XDG_SESSION_DESKTOP
    DESKTOP_ENV="$XDG_SESSION_DESKTOP"
    case "$DESKTOP_ENV" in
    Hyprland)
      echo "Setting wallpaper for Hyprland (auto-detected)..."
      hyprctl hyprpaper unload all
      hyprctl hyprpaper preload "$OUTPUT_PATH"
      hyprctl hyprpaper wallpaper ",$OUTPUT_PATH"
      echo "Hyprland wallpaper set to: $OUTPUT_PATH"
      ;;
    i3)
      echo "Setting wallpaper for i3 (auto-detected)..."
      DISPLAY=:0.0 feh --bg-fill "$OUTPUT_PATH"
      echo "i3 wallpaper set to: $OUTPUT_PATH"
      ;;
    *)
      echo "Desktop environment '$DESKTOP_ENV' not specifically handled for wallpaper setting."
      echo "Use the --session argument to specify 'hyprland' or 'i3'."
      ;;
    esac
    ;;
  *)
    echo "Invalid session type: '$SESSION'. Use 'hyprland' or 'i3'."
    ;;
  esac
else
  echo "Wallpaper setting is only implemented for Linux."
fi
