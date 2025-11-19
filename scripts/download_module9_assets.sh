#!/bin/bash

# Module 9 Asset Download Script
# This script helps download assets from Figma URLs listed in the asset manifest
# Note: Figma URLs expire after 7 days, so download assets promptly

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Asset directory
ASSET_DIR="assets/orders/track_invoice"

# Create directory if it doesn't exist
mkdir -p "$ASSET_DIR"

echo -e "${GREEN}Module 9 Asset Download Script${NC}"
echo "=================================="
echo ""
echo "This script downloads assets from Figma URLs."
echo "Note: URLs expire after 7 days from when they were generated."
echo ""

# Check if curl is available
if ! command -v curl &> /dev/null; then
    echo -e "${RED}Error: curl is not installed. Please install curl first.${NC}"
    exit 1
fi

# Function to download an asset
download_asset() {
    local url=$1
    local filename=$2
    local description=$3
    
    echo -e "${YELLOW}Downloading: $description${NC}"
    echo "  URL: $url"
    echo "  Saving to: $ASSET_DIR/$filename"
    
    if curl -L -f -o "$ASSET_DIR/$filename" "$url" 2>/dev/null; then
        echo -e "${GREEN}  ✓ Successfully downloaded $filename${NC}"
    else
        echo -e "${RED}  ✗ Failed to download $filename${NC}"
        echo "  The URL may have expired or the asset may not be accessible."
        return 1
    fi
    echo ""
}

# Download assets from Figma URLs
# Note: Update these URLs if they expire (check docs/module9_track_order_invoice_assets.md)

echo "Starting downloads..."
echo ""

# Icons
download_asset \
    "https://www.figma.com/api/mcp/asset/0debb2d8-fef1-4061-a32f-58e479ed8c78" \
    "icon_check_circle.png" \
    "Check Circle Icon (completed tracking step)"

download_asset \
    "https://www.figma.com/api/mcp/asset/d0197aa9-e3a0-4488-b911-bb95e730f5a9" \
    "icon_radio_unchecked.png" \
    "Radio Unchecked Icon (pending tracking step)"

download_asset \
    "https://www.figma.com/api/mcp/asset/430362ee-b878-46b5-bccf-978540d8feb9" \
    "icon_close_small.png" \
    "Close Small Icon"

download_asset \
    "https://www.figma.com/api/mcp/asset/5a1eb652-c670-4772-8631-0b29ffc569ea" \
    "icon_article.png" \
    "Article Icon (Invoice button)"

download_asset \
    "https://www.figma.com/api/mcp/asset/6079063e-2d27-49e7-ab36-d24c7ed33988" \
    "icon_home.png" \
    "Home Icon (address icon)"

# Product Images
download_asset \
    "https://www.figma.com/api/mcp/asset/79967cbb-5052-4e09-9bc4-6f15258df414" \
    "product_bose_headphones.png" \
    "Bose Headphones Product Image (Order Detail)"

download_asset \
    "https://www.figma.com/api/mcp/asset/b9e9091a-b0e7-4a69-9833-2af024f23e39" \
    "product_bose_headphones_invoice.png" \
    "Bose Headphones Product Image (Invoice Screen)"

echo "=================================="
echo -e "${GREEN}Download complete!${NC}"
echo ""
echo "Downloaded assets are in: $ASSET_DIR"
echo ""
echo "Next steps:"
echo "1. Verify all assets downloaded correctly"
echo "2. Check that assets display properly in the app"
echo "3. If any assets failed, check the URLs in docs/module9_track_order_invoice_assets.md"
echo "   (URLs expire after 7 days and may need to be regenerated from Figma)"

