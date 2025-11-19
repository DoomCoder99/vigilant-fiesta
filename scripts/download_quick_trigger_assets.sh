#!/bin/bash

# Script to download Quick Trigger assets from Figma MCP URLs
# These URLs are valid for 7 days from when they were generated

# Create assets directory if it doesn't exist
mkdir -p assets/quick_trigger

echo "Downloading Quick Trigger assets..."
echo ""

# Download each asset (using parallel arrays)
urls=(
  "https://www.figma.com/api/mcp/asset/1402c0af-558c-4b02-b556-a63022519e22"
  "https://www.figma.com/api/mcp/asset/f26b5ba0-cf93-4407-a47a-7c5b8ab2322c"
  "https://www.figma.com/api/mcp/asset/0c0a6c60-0b6d-4975-9aff-0d3bda72ff89"
  "https://www.figma.com/api/mcp/asset/a86f3d95-2053-49f3-8317-09741c1c64af"
  "https://www.figma.com/api/mcp/asset/1731131b-ce23-493a-8956-6df7cefc68eb"
  "https://www.figma.com/api/mcp/asset/abdfaaac-856b-49d9-ad01-b987f9737dfe"
  "https://www.figma.com/api/mcp/asset/79ca1ecd-4b96-4a40-9a05-0cc7498b4806"
  "https://www.figma.com/api/mcp/asset/954c3b07-fc01-4753-b164-f113e6251609"
)

filenames=(
  "agent_avatar.png"
  "lightning_icon.png"
  "hide_icon.png"
  "star_icon.png"
  "shield_icon.png"
  "shopping_cart_icon.png"
  "call_icon.png"
  "confetti_icon.png"
)

# Download each asset
for i in "${!urls[@]}"; do
  url="${urls[$i]}"
  filename="${filenames[$i]}"
  echo "Downloading $filename..."
  
  # Use curl to download the asset
  if curl -L -f -o "assets/quick_trigger/$filename" "$url" 2>/dev/null; then
    echo "  ✓ Successfully downloaded $filename"
  else
    echo "  ✗ Failed to download $filename"
    echo "  URL: $url"
    echo "  Note: URLs are valid for 7 days. You may need to regenerate them from Figma."
  fi
done

echo ""
echo "Download complete!"
echo ""
echo "Note: If downloads failed, you can:"
echo "1. Export assets directly from Figma using the node IDs in docs/module7_quick_trigger_asset_manifest.md"
echo "2. Or regenerate URLs using Figma MCP get_design_context tool"
echo ""
echo "Asset specifications:"
echo "- Agent avatar: 80x80px (2x for 40x40dp display)"
echo "- Lightning icon: 64x64px (2x for 32x32dp display)"
echo "- Hide icon: 40x40px (2x for 20x20dp display)"
echo "- Star icon: 16x16px (2x for 8x8dp display)"
echo "- Shield icon: 40x40px (2x for 20x20dp display)"
echo "- Shopping cart icon: 32x32px (2x for 16x16dp display)"
echo "- Call icon: 32x32px (2x for 16x16dp display)"
echo "- Confetti icon: 256x256px (2x for 128x128dp display)"

