#!/bin/bash

# Convert SVG assets to PNG format for Flutter compatibility
# Requires: rsvg-convert (brew install librsvg) or Inkscape

set -e

ASSETS_DIR="assets/support_chat"
TEMP_DIR="/tmp/support_chat_conversion"

mkdir -p "$TEMP_DIR"

# Check for rsvg-convert (librsvg)
if command -v rsvg-convert &> /dev/null; then
    CONVERTER="rsvg-convert"
elif command -v inkscape &> /dev/null; then
    CONVERTER="inkscape"
else
    echo "Error: Neither rsvg-convert nor inkscape found."
    echo "Install with: brew install librsvg"
    echo "Or: brew install inkscape"
    exit 1
fi

echo "Converting SVG files to PNG..."

for svg_file in "$ASSETS_DIR"/*.svg "$ASSETS_DIR"/*.png; do
    if [ ! -f "$svg_file" ]; then
        continue
    fi
    
    # Check if file is actually SVG
    if file "$svg_file" | grep -q "SVG"; then
        filename=$(basename "$svg_file")
        png_filename="${filename%.*}.png"
        
        echo "Converting $filename to $png_filename..."
        
        if [ "$CONVERTER" = "rsvg-convert" ]; then
            rsvg-convert -w 32 -h 32 "$svg_file" -o "$ASSETS_DIR/$png_filename"
        elif [ "$CONVERTER" = "inkscape" ]; then
            inkscape "$svg_file" --export-type=png --export-filename="$ASSETS_DIR/$png_filename" -w 32 -h 32
        fi
        
        # Remove original SVG if conversion successful
        if [ -f "$ASSETS_DIR/$png_filename" ]; then
            rm "$svg_file"
            echo "✓ Converted $filename"
        fi
    fi
done

echo "Conversion complete!"

