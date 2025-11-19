#!/bin/bash

# Module 11: Search - Asset Download Script
# Downloads all image assets from Figma URLs

set -e

# Create asset directory
mkdir -p assets/search

echo "Downloading Search Module assets..."

# Search - Initial state icons
echo "Downloading search bar icons..."
curl -f -o assets/search/icon_arrow_left.png "https://www.figma.com/api/mcp/asset/affe74be-c8f8-48a4-96f0-174e25050bb1" || echo "Failed: icon_arrow_left.png"
curl -f -o assets/search/icon_cancel.png "https://www.figma.com/api/mcp/asset/94221e85-de93-42a0-8824-6463075c5174" || echo "Failed: icon_cancel.png"

# Search - On enter (service/product images)
echo "Downloading search result images..."
curl -f -o assets/search/service_1_switch.png "https://www.figma.com/api/mcp/asset/f4ce158c-3e35-4ebf-b28a-f3e661cfcd00" || echo "Failed: service_1_switch.png"
curl -f -o assets/search/service_2_switches.png "https://www.figma.com/api/mcp/asset/7b77d946-e87c-4923-baf5-c8fceef96fb4" || echo "Failed: service_2_switches.png"
curl -f -o assets/search/service_more_switches.png "https://www.figma.com/api/mcp/asset/8cceefb3-bf55-4559-beda-66b71d13e0a8" || echo "Failed: service_more_switches.png"
curl -f -o assets/search/service_power_switch.png "https://www.figma.com/api/mcp/asset/949a772d-f11e-4bd1-b81a-1b13693ba770" || echo "Failed: service_power_switch.png"

# Product images
curl -f -o assets/search/product_single_pole_switch.png "https://www.figma.com/api/mcp/asset/98c4c07a-81b8-4cbc-9ead-7012728448db" || echo "Failed: product_single_pole_switch.png"
curl -f -o assets/search/product_double_pole_switch.png "https://www.figma.com/api/mcp/asset/58f0a503-9df2-46f4-bec6-085082350d90" || echo "Failed: product_double_pole_switch.png"
curl -f -o assets/search/product_mylinc_switch.png "https://www.figma.com/api/mcp/asset/edc1358c-723e-4e1e-bf21-00c7f8fc6e6a" || echo "Failed: product_mylinc_switch.png"

# Category tab product images (same as on enter, but different URLs)
curl -f -o assets/search/product_single_pole_switch_tab.png "https://www.figma.com/api/mcp/asset/2c739291-3185-4ef7-81b3-f1d9d35e8bff" || echo "Failed: product_single_pole_switch_tab.png"
curl -f -o assets/search/product_double_pole_switch_tab.png "https://www.figma.com/api/mcp/asset/da63734f-bb60-4b20-8f06-1cc8331bf8ca" || echo "Failed: product_double_pole_switch_tab.png"
curl -f -o assets/search/product_mylinc_switch_tab.png "https://www.figma.com/api/mcp/asset/2ab00f73-10f8-41ee-b700-c795dc45b42b" || echo "Failed: product_mylinc_switch_tab.png"

# Search - Not found illustration
echo "Downloading not found illustration..."
curl -f -o assets/search/illustration_not_found.png "https://www.figma.com/api/mcp/asset/a7e212ae-7cf1-4628-8274-96cb221bd579" || echo "Failed: illustration_not_found.png"
curl -f -o assets/search/ellipse_not_found.png "https://www.figma.com/api/mcp/asset/ea23a37b-b15e-4ec3-9690-b6a1b5282259" || echo "Failed: ellipse_not_found.png"

# Star icon (reuse existing if available, otherwise download)
if [ ! -f "assets/images/star_1.png" ]; then
  curl -f -o assets/search/star_icon.png "https://www.figma.com/api/mcp/asset/a2ad885f-fb7e-4726-bf5a-a9b510bd9b21" || echo "Failed: star_icon.png"
fi

echo "Asset download complete!"
echo "Note: Some assets may fail if Figma URLs have expired (valid for 7 days)"
echo "Check docs/module11_asset_manifest.md for manual download instructions"

