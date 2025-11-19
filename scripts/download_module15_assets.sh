#!/bin/bash

# Module 15: Support Chat Assets Download Script
# Downloads all required images from Figma MCP asset URLs

set -e

ASSETS_DIR="assets/support_chat"
mkdir -p "$ASSETS_DIR"

# Color codes for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}Downloading Module 15 Support Chat assets...${NC}"

# Function to download an asset
download_asset() {
    local url=$1
    local filename=$2
    local description=$3
    
    echo -e "${YELLOW}Downloading $description...${NC}"
    
    if curl -f -s -o "$ASSETS_DIR/$filename" "$url"; then
        echo -e "${GREEN}✓ Downloaded $filename${NC}"
    else
        echo -e "${RED}✗ Failed to download $filename${NC}"
        return 1
    fi
}

# Note: These URLs are from Figma MCP design context calls
# They expire after 7 days. If expired, re-run get_design_context for each frame.

# icon_add.png - From multiple frames (1:29729, 1:29775, etc.)
download_asset \
    "https://www.figma.com/api/mcp/asset/2da3fbd4-75a7-40fa-ba15-401c0a7ad27c" \
    "icon_add.png" \
    "Add icon"

# icon_more_vert.png - From multiple frames (1:29739, 1:29793, etc.)
download_asset \
    "https://www.figma.com/api/mcp/asset/24ea899f-07a6-42d4-9706-e9d54e095603" \
    "icon_more_vert.png" \
    "More vert icon"

# icon_check_done_all.png - Message status icon (1:29835, 1:29948, etc.)
download_asset \
    "https://www.figma.com/api/mcp/asset/0df58e2f-f09e-4338-b248-a6891dbe5a8f" \
    "icon_check_done_all.png" \
    "Check done all icon"

# icon_check.png - Message sent status (1:29783)
download_asset \
    "https://www.figma.com/api/mcp/asset/412f46ed-ced9-4be8-ab48-117a1b7f4685" \
    "icon_check.png" \
    "Check icon"

# icon_mic.png - Voice input button (1:30442)
download_asset \
    "https://www.figma.com/api/mcp/asset/c7af5a2a-f029-48fd-81ad-442fa1f71f58" \
    "icon_mic.png" \
    "Mic icon"

# icon_check_circle.png - Mark as resolved (1:30222, 1:30198)
download_asset \
    "https://www.figma.com/api/mcp/asset/6e4c0b49-00f2-4494-94fc-1f3521226e2e" \
    "icon_check_circle.png" \
    "Check circle icon"

# icon_stat_2.png - Escalate icon (1:30203)
download_asset \
    "https://www.figma.com/api/mcp/asset/8d7107a9-bd9e-4992-80c9-04dad9042bc3" \
    "icon_stat_2.png" \
    "Stat 2 icon"

# icon_flag.png - Report icon (1:30208, 1:30236)
download_asset \
    "https://www.figma.com/api/mcp/asset/d7b467cf-214a-46ba-a812-c2e907867aab" \
    "icon_flag.png" \
    "Flag icon"

# icon_download.png - Download chat icon (1:30243)
download_asset \
    "https://www.figma.com/api/mcp/asset/b85f2258-3487-4963-96b0-5c3e203cc656" \
    "icon_download.png" \
    "Download icon"

# icon_keyboard_double_arrow_up.png - Escalate alternative (1:30229)
download_asset \
    "https://www.figma.com/api/mcp/asset/f2b5d069-39db-4d1f-a439-df1851e5e551" \
    "icon_keyboard_double_arrow_up.png" \
    "Keyboard double arrow up icon"

echo -e "\n${GREEN}All assets downloaded successfully!${NC}"
echo -e "${YELLOW}Note: If any downloads failed, the URLs may have expired (7-day limit).${NC}"
echo -e "${YELLOW}Re-run get_design_context for the relevant frames to get fresh URLs.${NC}"

