#!/bin/bash
#
# Reduces the color depth of all screenshots to 32 colors.
#
# Requires: imagemagick (convert command)
#
# ! Images must be PNGs !
#
# @date 2020-05-18, Refactored on 2024-04-12.
# @modified 2024-06-18 Moved to new website-only project.
# @author Ikaros Kappler
 

# Define some colors
_RED='\033[0;31m'
_GREEN='\033[0;32m'
_PURPLE='\033[0;35m'
_GREY="\033[0;37m"
_NC='\033[0m'
 
# Trailing slashes will be ensured later again.
SOURCE_DIR="../../plotboilerplate/screenshots/screenshots-fullcolor/"
DEST_DIR="../static/img/screenshots/"
DEST_DIR2="../static/repo/screenshots/"

if [ $# -eq 0 ]
  then
    echo "[optimizeScreenshots] No arguments given. Using default directories (input=$SOURCE_DIR, output=$DEST_DIR)"
elif [ $# -le 2 ]
    then
    echo "[optimizeScreenshots] Please pass 0 (zero) or two arguments: input- and output-directory"
    exit 1
else
    SOURCE_DIR=$(ensureTrailingSlash "$1")
    DEST_DIR=$(ensureTrailingSlash "$2");
    echo "[optimizeScreenshots] Using directories (input=$SOURCE_DIR, output=$DEST_DIR)"
fi
 
# Take files from ../screenhots/screenshots-fullcolor/
# Output directory is ../screenshots/
 

source "$(dirname "$0")/function-ensureTrailingSlash.sh"

# source_directory=$(ensureTrailingSlash $SOURCE_SCREENSHOT_DIRECTORY);
echo " source_directory=$SOURCE_DIR"
 
# Iterate through all large start-JPG files.
for file in "$SOURCE_DIR"*.{png,PNG}; do

    echo "FILE: $file"
    filename=$(basename "$file")
    
    # Process only regular files
    if [ -f "$file" ]; then
	
        echo -e "   ${_PURPLE}Generating optimized screensot for file ${filename} ${_NC}"
        echo -e "   Output dir: ${DEST_DIR}$filename"
        # convert "$file" -resize 128 -define jpeg:extent=10kb "./$dirname_thumbs/$filename"
        # convert -colors 32 "../screenshots/screenshots-fullcolor/$filename" "../screenshots/$filename"
        convert -colors 32 "${SOURCE_DIR}$filename" "${DEST_DIR}$filename"
        
        echo -e "   ${_GREEN}Done.${_NC}"

    fi
	
done

# Finally copy to publis repo dir
mkdir -p "${DEST_DIR2}" 
cp "${DEST_DIR}/"*.png "${DEST_DIR2}/"

echo "Copied."
