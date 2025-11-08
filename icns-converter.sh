#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Define input and output directories
INPUT_DIR="${SCRIPT_DIR}/input"
OUTPUT_DIR="${SCRIPT_DIR}/file-output"

# Check if input directory exists
if [ ! -d "${INPUT_DIR}" ]; then
    echo "Error: Input directory '${INPUT_DIR}' does not exist."
    echo "Please create the 'input' folder and add PNG images to it."
    exit 1
fi

# Create output directory if it doesn't exist
mkdir -p "${OUTPUT_DIR}"

# Check if there are any PNG files in the input directory
shopt -s nullglob
PNG_FILES=("${INPUT_DIR}"/*.png)
shopt -u nullglob

if [ ${#PNG_FILES[@]} -eq 0 ]; then
    echo "No PNG files found in '${INPUT_DIR}'"
    exit 1
fi

echo "Found ${#PNG_FILES[@]} PNG file(s) to convert..."
echo ""

# Process each PNG file
for INPUT_PNG in "${PNG_FILES[@]}"; do
    # Get the base name without path and extension
    BASENAME=$(basename "${INPUT_PNG}" .png)
    
    echo "Converting: ${BASENAME}.png"
    
    # Create a temporary directory for the icon set
    ICONSET_DIR="${OUTPUT_DIR}/${BASENAME}.iconset"
    mkdir -p "${ICONSET_DIR}"
    
    # Resize and convert the PNG to various icon sizes
    magick "${INPUT_PNG}" -resize 16x16! "${ICONSET_DIR}/icon_16x16.png"
    magick "${INPUT_PNG}" -resize 32x32! "${ICONSET_DIR}/icon_16x16@2x.png"
    magick "${INPUT_PNG}" -resize 32x32! "${ICONSET_DIR}/icon_32x32.png"
    magick "${INPUT_PNG}" -resize 64x64! "${ICONSET_DIR}/icon_32x32@2x.png"
    magick "${INPUT_PNG}" -resize 128x128! "${ICONSET_DIR}/icon_128x128.png"
    magick "${INPUT_PNG}" -resize 256x256! "${ICONSET_DIR}/icon_128x128@2x.png" 
    magick "${INPUT_PNG}" -resize 512x512! "${ICONSET_DIR}/icon_256x256.png"

    # Create the .icns file in the output directory
    iconutil -c icns "${ICONSET_DIR}" -o "${OUTPUT_DIR}/${BASENAME}.icns"
    
    # Remove the temporary iconset directory
    rm -r "${ICONSET_DIR}"
    
    echo "✓ Created: ${OUTPUT_DIR}/${BASENAME}.icns"
    echo ""
done

echo "Conversion complete! All .icns files saved to '${OUTPUT_DIR}'"
