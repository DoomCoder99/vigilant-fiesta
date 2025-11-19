# Module 10: Profile & More - Asset Manifest

## Asset Download Instructions

All image assets need to be downloaded from Figma and placed in the appropriate folders. The URLs below are from the Figma MCP API and are valid for 7 days.

## Profile Assets (`assets/profile/`)

| Asset Name | Figma URL | Usage |
|------------|-----------|-------|
| `edit_icon.png` | https://www.figma.com/api/mcp/asset/7790ef41-d066-4d64-98a6-18ea0970edca | Edit button in profile header and address cards |
| `copy_icon.png` | https://www.figma.com/api/mcp/asset/f9d6ba2e-d38d-423d-a166-ec563d9efb41 | Copy referral link button |
| `share_icon.png` | https://www.figma.com/api/mcp/asset/a39b2ba8-d26c-46a7-944a-a35a96d16fca | Share referral link button |
| `profile_avatar.png` | https://www.figma.com/api/mcp/asset/daa7c18b-686f-4611-bf97-8bbee469c7f3 | Default profile avatar image |
| `notification_icon.png` | https://www.figma.com/api/mcp/asset/3f2fbe6b-70d6-4f53-9779-bd9f8c67c8a3 | Notification bell icon in app bar |
| `home_icon.png` | https://www.figma.com/api/mcp/asset/e0617238-04c6-42d0-8b8e-c61a67155afd | Home address type badge |
| `work_icon.png` | https://www.figma.com/api/mcp/asset/118b39ee-ab7a-43b4-8cf5-4652874ba92a | Work address type badge |
| `add_icon.png` | https://www.figma.com/api/mcp/asset/713579e8-07b4-4676-9d62-1c9b1c477500 | Add new address/card button |
| `close_icon.png` | https://www.figma.com/api/mcp/asset/b220b279-98c7-420f-a659-15c104081aac | Close button in popups |
| `mic_icon.png` | https://www.figma.com/api/mcp/asset/4c9dc3d6-a398-4f77-848b-7691aaf28813 | Voice input icon in form fields |
| `chevron_forward.png` | https://www.figma.com/api/mcp/asset/75a76bad-c1e3-4a77-8735-aebfb3169c26 | Forward chevron in language/theme selection |

## Wallet Assets (`assets/wallet/`)

| Asset Name | Figma URL | Usage |
|------------|-----------|-------|
| `wallet_icon.png` | https://www.figma.com/api/mcp/asset/11063687-5728-4c1a-829f-9926de12304e | Wallet icon in wallet screen |
| `card_icon.png` | https://www.figma.com/api/mcp/asset/9c395a27-654d-4d87-b35b-834125658e54 | Credit card icon in add card form |
| `mastercard.png` | (Use existing from rent_vehicle/payment/) | Mastercard logo for payment methods |

## Notifications Assets (`assets/notifications/`)

| Asset Name | Figma URL | Usage |
|------------|-----------|-------|
| `rent_vehicle.png` | https://www.figma.com/api/mcp/asset/35ae53b3-3669-4525-8ca9-c4104262378e | Rent vehicle notification icon |
| `delivery.png` | https://www.figma.com/api/mcp/asset/909da39a-a0c8-4b98-a759-2effc3c54642 | Delivery notification icon |
| `profile.png` | https://www.figma.com/api/mcp/asset/3469cf50-04ec-45e2-ae30-da96b31bfb37 | Profile notification icon |

## Documents Assets (`assets/documents/`)

| Asset Name | Figma URL | Usage |
|------------|-----------|-------|
| `driving_license.png` | https://www.figma.com/api/mcp/asset/e0986d20-7927-4d81-a2c8-dfa63e90b197 | Driving license document thumbnail |
| `maximize_icon.png` | https://www.figma.com/api/mcp/asset/a2b385b4-f8ec-45dc-b5c1-314b440118fb | View/fullscreen document icon |
| `upload_icon.png` | https://www.figma.com/api/mcp/asset/727cfc4e-4148-4635-9811-e64c4495a52d | Upload document icon |

## Coupons & Loyalty Assets (`assets/coupons_loyalty/`)

| Asset Name | Figma URL | Usage |
|------------|-----------|-------|
| `loyalty_card_1.png` | https://www.figma.com/api/mcp/asset/a2551cf6-f82b-42eb-af48-5349adbf78c0 | House cleaning loyalty card background |
| `loyalty_card_2.png` | https://www.figma.com/api/mcp/asset/889d81f9-d267-475a-a298-ec29460a9e6d | Driving instructor loyalty card background |
| `check_icon.png` | https://www.figma.com/api/mcp/asset/84f55c13-d4f5-4dbf-bc17-5a82979d55c3 | Checkmark for completed loyalty stamps |

## Additional Icons from Status Bar (Reused)

These icons are typically system icons but can be found in Figma:
- `bar-chart.png` - Signal strength icon
- `wifi.png` - WiFi icon  
- `battery-charging.png` - Battery icon
- `arrow-left.png` - Back arrow icon
- `chevron_right.png` - Right chevron icon

## Download Script

You can use this bash script to download all assets:

```bash
#!/bin/bash

# Profile assets
curl -o assets/profile/edit_icon.png "https://www.figma.com/api/mcp/asset/7790ef41-d066-4d64-98a6-18ea0970edca"
curl -o assets/profile/copy_icon.png "https://www.figma.com/api/mcp/asset/f9d6ba2e-d38d-423d-a166-ec563d9efb41"
curl -o assets/profile/share_icon.png "https://www.figma.com/api/mcp/asset/a39b2ba8-d26c-46a7-944a-a35a96d16fca"
curl -o assets/profile/profile_avatar.png "https://www.figma.com/api/mcp/asset/daa7c18b-686f-4611-bf97-8bbee469c7f3"
curl -o assets/profile/notification_icon.png "https://www.figma.com/api/mcp/asset/3f2fbe6b-70d6-4f53-9779-bd9f8c67c8a3"
curl -o assets/profile/home_icon.png "https://www.figma.com/api/mcp/asset/e0617238-04c6-42d0-8b8e-c61a67155afd"
curl -o assets/profile/work_icon.png "https://www.figma.com/api/mcp/asset/118b39ee-ab7a-43b4-8cf5-4652874ba92a"
curl -o assets/profile/add_icon.png "https://www.figma.com/api/mcp/asset/713579e8-07b4-4676-9d62-1c9b1c477500"
curl -o assets/profile/close_icon.png "https://www.figma.com/api/mcp/asset/b220b279-98c7-420f-a659-15c104081aac"
curl -o assets/profile/mic_icon.png "https://www.figma.com/api/mcp/asset/4c9dc3d6-a398-4f77-848b-7691aaf28813"
curl -o assets/profile/chevron_forward.png "https://www.figma.com/api/mcp/asset/75a76bad-c1e3-4a77-8735-aebfb3169c26"

# Wallet assets
curl -o assets/wallet/wallet_icon.png "https://www.figma.com/api/mcp/asset/11063687-5728-4c1a-829f-9926de12304e"
curl -o assets/wallet/card_icon.png "https://www.figma.com/api/mcp/asset/9c395a27-654d-4d87-b35b-834125658e54"

# Notification assets
curl -o assets/notifications/rent_vehicle.png "https://www.figma.com/api/mcp/asset/35ae53b3-3669-4525-8ca9-c4104262378e"
curl -o assets/notifications/delivery.png "https://www.figma.com/api/mcp/asset/909da39a-a0c8-4b98-a759-2effc3c54642"
curl -o assets/notifications/profile.png "https://www.figma.com/api/mcp/asset/3469cf50-04ec-45e2-ae30-da96b31bfb37"

# Document assets
curl -o assets/documents/driving_license.png "https://www.figma.com/api/mcp/asset/e0986d20-7927-4d81-a2c8-dfa63e90b197"
curl -o assets/documents/maximize_icon.png "https://www.figma.com/api/mcp/asset/a2b385b4-f8ec-45dc-b5c1-314b440118fb"
curl -o assets/documents/upload_icon.png "https://www.figma.com/api/mcp/asset/727cfc4e-4148-4635-9811-e64c4495a52d"

# Coupons & Loyalty assets
curl -o assets/coupons_loyalty/loyalty_card_1.png "https://www.figma.com/api/mcp/asset/a2551cf6-f82b-42eb-af48-5349adbf78c0"
curl -o assets/coupons_loyalty/loyalty_card_2.png "https://www.figma.com/api/mcp/asset/889d81f9-d267-475a-a298-ec29460a9e6d"
curl -o assets/coupons_loyalty/check_icon.png "https://www.figma.com/api/mcp/asset/84f55c13-d4f5-4dbf-bc17-5a82979d55c3"
```

## Note

- All Figma asset URLs expire after 7 days
- If URLs expire, regenerate them using Figma MCP `get_design_context` for the respective frames
- Fallback icons are implemented in code for missing assets
- Asset dimensions should match Figma specifications (typically 16x16, 20x20, 24x24, 32x32, etc.)

