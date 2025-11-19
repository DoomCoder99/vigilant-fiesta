#!/bin/bash

# Module 10: Profile & More - Asset Download Script
# Downloads all image assets from Figma URLs

set -e

# Create asset directories
mkdir -p assets/profile assets/wallet assets/notifications assets/documents assets/coupons_loyalty

echo "Downloading Profile assets..."
curl -f -o assets/profile/edit_icon.png "https://www.figma.com/api/mcp/asset/7790ef41-d066-4d64-98a6-18ea0970edca" || echo "Failed: edit_icon.png"
curl -f -o assets/profile/copy_icon.png "https://www.figma.com/api/mcp/asset/f9d6ba2e-d38d-423d-a166-ec563d9efb41" || echo "Failed: copy_icon.png"
curl -f -o assets/profile/share_icon.png "https://www.figma.com/api/mcp/asset/a39b2ba8-d26c-46a7-944a-a35a96d16fca" || echo "Failed: share_icon.png"
curl -f -o assets/profile/profile_avatar.png "https://www.figma.com/api/mcp/asset/daa7c18b-686f-4611-bf97-8bbee469c7f3" || echo "Failed: profile_avatar.png"
curl -f -o assets/profile/notification_icon.png "https://www.figma.com/api/mcp/asset/3f2fbe6b-70d6-4f53-9779-bd9f8c67c8a3" || echo "Failed: notification_icon.png"
curl -f -o assets/profile/home_icon.png "https://www.figma.com/api/mcp/asset/e0617238-04c6-42d0-8b8e-c61a67155afd" || echo "Failed: home_icon.png"
curl -f -o assets/profile/work_icon.png "https://www.figma.com/api/mcp/asset/118b39ee-ab7a-43b4-8cf5-4652874ba92a" || echo "Failed: work_icon.png"
curl -f -o assets/profile/add_icon.png "https://www.figma.com/api/mcp/asset/713579e8-07b4-4676-9d62-1c9b1c477500" || echo "Failed: add_icon.png"
curl -f -o assets/profile/close_icon.png "https://www.figma.com/api/mcp/asset/b220b279-98c7-420f-a659-15c104081aac" || echo "Failed: close_icon.png"
curl -f -o assets/profile/mic_icon.png "https://www.figma.com/api/mcp/asset/4c9dc3d6-a398-4f77-848b-7691aaf28813" || echo "Failed: mic_icon.png"
curl -f -o assets/profile/chevron_forward.png "https://www.figma.com/api/mcp/asset/75a76bad-c1e3-4a77-8735-aebfb3169c26" || echo "Failed: chevron_forward.png"

echo "Downloading Wallet assets..."
curl -f -o assets/wallet/wallet_icon.png "https://www.figma.com/api/mcp/asset/11063687-5728-4c1a-829f-9926de12304e" || echo "Failed: wallet_icon.png"
curl -f -o assets/wallet/card_icon.png "https://www.figma.com/api/mcp/asset/9c395a27-654d-4d87-b35b-834125658e54" || echo "Failed: card_icon.png"

echo "Downloading Notification assets..."
curl -f -o assets/notifications/rent_vehicle.png "https://www.figma.com/api/mcp/asset/35ae53b3-3669-4525-8ca9-c4104262378e" || echo "Failed: rent_vehicle.png"
curl -f -o assets/notifications/delivery.png "https://www.figma.com/api/mcp/asset/909da39a-a0c8-4b98-a759-2effc3c54642" || echo "Failed: delivery.png"
curl -f -o assets/notifications/profile.png "https://www.figma.com/api/mcp/asset/3469cf50-04ec-45e2-ae30-da96b31bfb37" || echo "Failed: profile.png"

echo "Downloading Document assets..."
curl -f -o assets/documents/driving_license.png "https://www.figma.com/api/mcp/asset/e0986d20-7927-4d81-a2c8-dfa63e90b197" || echo "Failed: driving_license.png"
curl -f -o assets/documents/maximize_icon.png "https://www.figma.com/api/mcp/asset/a2b385b4-f8ec-45dc-b5c1-314b440118fb" || echo "Failed: maximize_icon.png"
curl -f -o assets/documents/upload_icon.png "https://www.figma.com/api/mcp/asset/727cfc4e-4148-4635-9811-e64c4495a52d" || echo "Failed: upload_icon.png"

echo "Downloading Coupons & Loyalty assets..."
curl -f -o assets/coupons_loyalty/loyalty_card_1.png "https://www.figma.com/api/mcp/asset/a2551cf6-f82b-42eb-af48-5349adbf78c0" || echo "Failed: loyalty_card_1.png"
curl -f -o assets/coupons_loyalty/loyalty_card_2.png "https://www.figma.com/api/mcp/asset/889d81f9-d267-475a-a298-ec29460a9e6d" || echo "Failed: loyalty_card_2.png"
curl -f -o assets/coupons_loyalty/check_icon.png "https://www.figma.com/api/mcp/asset/84f55c13-d4f5-4dbf-bc17-5a82979d55c3" || echo "Failed: check_icon.png"

echo "Asset download complete!"
echo "Note: Some assets may fail if Figma URLs have expired (valid for 7 days)"
echo "Check docs/module10_asset_manifest.md for manual download instructions"

